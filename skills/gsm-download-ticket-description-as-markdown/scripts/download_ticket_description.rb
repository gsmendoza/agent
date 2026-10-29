#!/usr/bin/env ruby
# frozen_string_literal: true

# Downloads a Jira ticket's description as Markdown into the ticket's folder.
#
# Usage: download_ticket_description.rb [TICKET_KEY] [--stdout]
#   TICKET_KEY defaults to the ticket prefix of the current git branch (e.g. ATC-3095).
#   --stdout prints the Markdown instead of saving it.

require "json"
require "open3"
require "fileutils"

def load_dotenv(path)
  return unless File.exist?(path)

  File.foreach(path) do |line|
    next unless line =~ /\A\s*([A-Z0-9_]+)\s*=\s*(.*)\s*\z/

    key, value = Regexp.last_match(1), Regexp.last_match(2).strip.delete_prefix('"').delete_suffix('"').delete_prefix("'").delete_suffix("'")
    ENV[key] ||= value
  end
end

def current_branch
  out, status = Open3.capture2("git", "branch", "--show-current")
  status.success? ? out.strip : ""
end

# Converts Atlassian Document Format (ADF) nodes to Markdown.
class AdfToMarkdown
  def convert(doc)
    blocks(doc["content"] || []).join("\n\n").gsub(/\n{3,}/, "\n\n").strip + "\n"
  end

  private

  def blocks(nodes, indent: "")
    nodes.map { |node| block(node, indent:) }.reject { |text| text.nil? || text.strip.empty? }
  end

  def block(node, indent: "")
    content = node["content"] || []

    case node["type"]
    when "paragraph" then inline(content)
    when "heading" then "#{"#" * node.dig("attrs", "level").to_i} #{inline(content).strip}"
    when "bulletList" then list(content, indent:) { "- " }
    when "orderedList" then list(content, indent:) { |i| "#{node.dig("attrs", "order").to_i.clamp(1, nil) + i}. " }
    when "blockquote" then blocks(content).join("\n\n").lines.map { |l| l.strip.empty? ? ">" : "> #{l.chomp}" }.join("\n")
    when "codeBlock" then "```#{node.dig("attrs", "language")}\n#{content.map { |c| c["text"] }.join}\n```"
    when "rule" then "---"
    when "table" then table(content)
    when "mediaSingle", "mediaGroup" then content.map { |c| media(c) }.join("\n")
    when "media" then media(node)
    when "panel", "expand", "nestedExpand", "layoutSection", "layoutColumn"
      title = node.dig("attrs", "title")
      body = blocks(content).join("\n\n")
      title ? "**#{title}**\n\n#{body}" : body
    else
      content.any? ? blocks(content).join("\n\n") : inline([node])
    end
  end

  def list(items, indent:)
    items.each_with_index.map do |item, i|
      marker = yield(i)
      parts = (item["content"] || []).map do |child|
        if %w[bulletList orderedList].include?(child["type"])
          block(child, indent: indent + (" " * marker.length))
        else
          block(child, indent:)
        end
      end
      first, *rest = parts
      lines = ["#{indent}#{marker}#{first}"]
      rest.each { |part| lines << (part.start_with?(indent + " ") ? part : "#{indent}#{" " * marker.length}#{part}") }
      lines.join("\n")
    end.join("\n")
  end

  def table(rows)
    cells = rows.map do |row|
      (row["content"] || []).map { |cell| blocks(cell["content"] || []).join(" ").gsub("\n", " ").gsub("|", "\\|") }
    end
    return "" if cells.empty?

    width = cells.map(&:length).max
    cells = cells.map { |row| row + [""] * (width - row.length) }
    header, *body = cells
    (["| #{header.join(" | ")} |", "|#{"---|" * width}"] + body.map { |row| "| #{row.join(" | ")} |" }).join("\n")
  end

  def media(node)
    alt = node.dig("attrs", "alt")
    alt ? "[Attachment: #{alt}]" : "[Attachment]"
  end

  def inline(nodes)
    nodes.map do |node|
      case node["type"]
      when "text" then marked(node["text"].to_s, node["marks"] || [])
      when "hardBreak" then "  \n"
      when "inlineCard", "blockCard", "embedCard" then "<#{node.dig("attrs", "url")}>"
      when "mention" then node.dig("attrs", "text").to_s
      when "emoji" then node.dig("attrs", "text") || node.dig("attrs", "shortName").to_s
      when "status" then "[#{node.dig("attrs", "text")}]"
      when "date" then Time.at(node.dig("attrs", "timestamp").to_i / 1000).utc.strftime("%Y-%m-%d")
      else inline(node["content"] || [])
      end
    end.join
  end

  def marked(text, marks)
    return text if text.strip.empty?

    lead = text[/\A\s*/]
    trail = text[/\s*\z/]
    core = text.strip

    marks.each do |mark|
      core =
        case mark["type"]
        when "code" then "`#{core}`"
        when "strong" then "**#{core}**"
        when "em" then "*#{core}*"
        when "strike" then "~~#{core}~~"
        when "link"
          href = mark.dig("attrs", "href")
          core == href ? "<#{href}>" : "[#{core.gsub(/([\[\]])/) { "\\#{Regexp.last_match(1)}" }}](#{href})"
        else core
        end
    end

    "#{lead}#{core}#{trail}"
  end
end

args = ARGV.dup
to_stdout = args.delete("--stdout")
branch = current_branch
key = args.first || branch[/\A[A-Z][A-Z0-9]+-\d+/]
abort "Error: no ticket key given and none found in branch #{branch.inspect}." unless key

load_dotenv(File.join(Dir.pwd, ".env"))
abort "Error: JIRA_API_TOKEN is not set (env or .env)." if ENV["JIRA_API_TOKEN"].to_s.empty?

raw, status = Open3.capture2("jira", "issue", "view", key, "--raw")
abort "Error: `jira issue view #{key} --raw` failed." unless status.success?

fields = JSON.parse(raw).fetch("fields")
jira_config = File.join(Dir.home, ".config", ".jira", ".config.yml")
server = File.exist?(jira_config) ? File.read(jira_config)[/^server:\s*(\S+)/, 1] : nil
server ||= "https://agencytoolchest.atlassian.net"

markdown = +"# #{key}: #{fields["summary"]}\n\n"
markdown << "Source: #{server.chomp("/")}/browse/#{key}\n\n"
markdown << AdfToMarkdown.new.convert(fields["description"] || {"content" => []})

attachments = fields["attachment"] || []
if attachments.any?
  markdown << "\n## Attachments\n\n"
  attachments.each { |a| markdown << "- [#{a["filename"]}](#{a["content"]})\n" }
end

if to_stdout
  puts markdown
  exit
end

tickets_path = ENV["GSM_TICKETS_PATH"] || File.join(ENV["GSM_RESOURCES_PATH"] || "../resources", "tickets")
ticket_dir = Dir.glob(File.join(tickets_path, "#{key}*")).find { |d| File.directory?(d) } ||
  File.join(tickets_path, branch.start_with?(key) ? branch : key)
FileUtils.mkdir_p(ticket_dir)

slug = "#{key}-ticket-description".downcase
path = File.join(ticket_dir, "#{slug}-#{Time.now.strftime("%Y%m%d-%H%M")}.md")
File.write(path, markdown)
puts File.expand_path(path)
