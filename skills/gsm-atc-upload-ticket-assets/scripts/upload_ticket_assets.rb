#!/usr/bin/env ruby
# frozen_string_literal: true

require "optparse"
require "open3"
require "pathname"

def load_dotenv
  search_paths = [
    Dir.pwd,
    git_repo_root
  ].compact.uniq

  search_paths.each do |dir|
    env_file = File.join(dir, ".env")
    next unless File.file?(env_file)

    File.foreach(env_file) do |line|
      line = line.strip
      next if line.empty? || line.start_with?("#")

      key, value = line.split("=", 2)
      next unless key && value

      key = key.strip
      value = value.strip.gsub(/\A["']|["']\z/, "")
      ENV[key] ||= value
    end
  end
end

def git_repo_root
  stdout, status = Open3.capture2("git", "rev-parse", "--show-toplevel")
  status.success? ? stdout.strip : nil
rescue StandardError
  nil
end

def current_git_branch
  stdout, status = Open3.capture2("git", "branch", "--show-current")
  if status.success? && !stdout.strip.empty?
    stdout.strip
  else
    nil
  end
rescue StandardError
  nil
end

def verify_rclone_installed!
  _stdout, status = Open3.capture2("rclone", "--version")
  unless status.success?
    warn "Error: rclone executable not working or returned non-zero status."
    exit 1
  end
rescue Errno::ENOENT
  warn "Error: rclone is not installed or not in PATH."
  exit 1
end

def snake_case(str)
  str.gsub(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2')
     .gsub(/([a-z\d])([A-Z])/, '\1_\2')
     .tr("-", "_")
     .downcase
end

options = {
  dry_run: false,
  branch: nil,
  resources_path: nil,
  tickets_path: nil,
  seeds_path: nil,
  remote: "narralabs:home/tickets"
}

parser = OptionParser.new do |opts|
  opts.banner = "Usage: upload_ticket_assets.rb [options]"

  opts.on("-b", "--branch BRANCH", "Git branch to resolve ticket from (defaults to current branch)") do |b|
    options[:branch] = b
  end

  opts.on("-d", "--dry-run", "Print planned actions without performing file transfers") do
    options[:dry_run] = true
  end

  opts.on("--resources-path PATH", "Base resources directory path") do |p|
    options[:resources_path] = p
  end

  opts.on("--tickets-path PATH", "Tickets directory path") do |p|
    options[:tickets_path] = p
  end

  opts.on("--seeds-path PATH", "Seeds directory path") do |p|
    options[:seeds_path] = p
  end

  opts.on("--remote REMOTE", "Rclone destination remote directory (default: narralabs:home/tickets)") do |r|
    options[:remote] = r
  end

  opts.on("-h", "--help", "Show this help message") do
    puts opts
    exit 0
  end
end

parser.parse!

load_dotenv
verify_rclone_installed!

branch = options[:branch] || current_git_branch
if branch.nil? || branch.empty?
  warn "Error: Unable to detect git branch. Please run inside a git repository or provide --branch <name>."
  exit 1
end

ticket_issue_match = branch.match(/\A([A-Za-z]+-\d+)/)
ticket_issue = ticket_issue_match ? ticket_issue_match[1] : nil

resources_path = options[:resources_path] || ENV["GSM_RESOURCES_PATH"] || "../resources"
tickets_path = options[:tickets_path] || ENV["GSM_TICKETS_PATH"] || File.join(resources_path, "tickets")
seeds_path = options[:seeds_path] || ENV["GSM_SEEDS_PATH"] || File.join(resources_path, "seeds")

ticket_dir = nil
if Dir.exist?(File.join(tickets_path, branch))
  ticket_dir = File.join(tickets_path, branch)
elsif ticket_issue
  matches = Dir.glob(File.join(tickets_path, "#{ticket_issue}*")).select { |f| File.directory?(f) }
  ticket_dir = matches.first
end

if ticket_dir.nil? || !Dir.exist?(ticket_dir)
  warn "Warning: Could not find ticket directory for branch '#{branch}' under #{tickets_path}"
end

demo_file = nil
if ticket_dir && Dir.exist?(ticket_dir)
  demo_candidates = Dir.glob(File.join(ticket_dir, "*demo*.mp4"))
  demo_candidates = Dir.glob(File.join(ticket_dir, "*.mp4")) if demo_candidates.empty?

  demo_file = demo_candidates.max_by { |f| File.mtime(f) }
end

seed_bundle_dir = nil
if Dir.exist?(seeds_path) && ticket_issue
  snake_ticket = snake_case(ticket_issue)
  seed_candidates = Dir.glob(File.join(seeds_path, "#{snake_ticket}*"))
                       .select { |f| File.directory?(f) && File.basename(f) != "0-archive" }

  seed_bundle_dir = seed_candidates.first

  if seed_bundle_dir.nil?
    snake_branch = snake_case(branch)
    full_branch_candidate = File.join(seeds_path, snake_branch)
    seed_bundle_dir = full_branch_candidate if Dir.exist?(full_branch_candidate)
  end
end

if demo_file.nil? && seed_bundle_dir.nil?
  warn "Error: Neither demo video nor seed script bundle was found."
  warn "  Branch: #{branch}"
  warn "  Tickets path: #{tickets_path}"
  warn "  Seeds path: #{seeds_path}"
  exit 1
end

warn "Warning: No demo video found in #{ticket_dir || tickets_path}" if demo_file.nil?
warn "Warning: No seed script bundle found in #{seeds_path}" if seed_bundle_dir.nil?

dest_folder_name = ticket_dir ? File.basename(ticket_dir) : branch
dest_remote = "#{options[:remote]}/#{dest_folder_name}"

client_id = ENV["GSM_NARRALABS_GOOGLE_DRIVE_CLIENT_ID"]
client_secret = ENV["GSM_NARRALABS_GOOGLE_DRIVE_CLIENT_SECRET"]

extra_rclone_flags = []
extra_rclone_flags += ["--drive-client-id", client_id] if client_id && !client_id.empty?
extra_rclone_flags += ["--drive-client-secret", client_secret] if client_secret && !client_secret.empty?

puts "=== ATC Upload Ticket Assets ==="
puts "Branch:              #{branch}"
puts "Ticket Issue:        #{ticket_issue || 'N/A'}"
puts "Ticket Directory:    #{ticket_dir || 'Not found'}"
puts "Demo File:           #{demo_file || 'None'}"
puts "Seed Script Bundle:  #{seed_bundle_dir || 'None'}"
puts "Destination Remote:  #{dest_remote}"
puts "Mode:                #{options[:dry_run] ? 'DRY-RUN (no files transferred)' : 'LIVE'}"
puts "================================"

transfers = []

if demo_file
  transfers << {
    type: "Demo File",
    src: demo_file,
    cmd: ["rclone", "copy", demo_file, dest_remote] + extra_rclone_flags,
    display_dest: "#{dest_remote}/#{File.basename(demo_file)}"
  }
end

if seed_bundle_dir
  bundle_name = File.basename(seed_bundle_dir)
  transfers << {
    type: "Seed Script Bundle",
    src: seed_bundle_dir,
    cmd: ["rclone", "copy", seed_bundle_dir, "#{dest_remote}/#{bundle_name}"] + extra_rclone_flags,
    display_dest: "#{dest_remote}/#{bundle_name}/"
  }
end

transfers.each do |transfer|
  puts "\n--> Uploading #{transfer[:type]}:"
  puts "    Source:      #{transfer[:src]}"
  puts "    Destination: #{transfer[:display_dest]}"

  if options[:dry_run]
    puts "    [DRY-RUN] Command: #{transfer[:cmd].join(' ')}"
  else
    puts "    Executing rclone copy..."
    system(*transfer[:cmd])
    unless $?.success?
      warn "Error: Failed to upload #{transfer[:type]} to #{transfer[:display_dest]}"
      exit $?.exitstatus
    end
  end
end

puts "\n✓ Successfully completed#{' (dry-run)' if options[:dry_run]}!"
puts "Remote destination: #{dest_remote}"
