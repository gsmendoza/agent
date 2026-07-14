---
name: gsm-review-code
description: Invoke when user asks for a code review
user_invocable: true
---

# GSM > Review > Code

## Input

- Git diff to review.
  - Default: Diff of the current branch against its parent branch.

  - The user might specify a different review scope. Examples:
    - Uncommitted changes (unstaged or staged)
    - The last commit

- Model to use for the review.
  - If not specified, ask the user.

## Process

- Perform a general code review, focusing on these areas:
  - Correctness
  - Performance
  - Security
  - Design & Architecture
  - Comprehensibility

- See the General Guidelines and Domain-specific Guidelines sections below for specific rules within these areas.

## General Guidelines

### Correctness

- Prefer explicit nil or truthiness checks for non-string values in Ruby
  - When checking non-string values in Ruby, check the truthiness of the value directly or check `value.nil?` (rather than calling `present?` or `blank?`), so that the check is explicit and avoids unexpected boolean behavior (e.g. `false.blank?` returning `true`).

### Design & Architecture

- Separate core/library code from execution contexts
  - When writing core or library logic, keep it independent of execution contexts (e.g., CLI, UI, or process control), so that it can be reused across different runtimes.

- Target specific exception classes when rescuing
  - When handling errors with rescue or catch blocks, target the narrowest exception class possible, so that unrelated or unexpected exceptions are not silently swallowed.

- Prefer `StandardError` (or bare `rescue`) over `RuntimeError` when catching command/system failures
  - When rescuing around helpers that run external commands or may raise system-level errors (e.g. `Errno::ENOENT`), rescue `StandardError` or use a bare `rescue` (which defaults to `StandardError`), so that failures such as `Errno::*` are caught. Do not recommend `rescue RuntimeError`: many of those failures inherit from `StandardError` but not from `RuntimeError`, so the rescue is bypassed and the script crashes. Still avoid rescuing `Exception`.

- Enforce fail-fast on critical paths and safety checks
  - When executing critical paths or safety checks, do not swallow exceptions silently (e.g., by returning empty values or nil), so that failures are not mistakenly assumed to be successful.

### Comprehensibility

- Invoke gsm-build-best-practice-rspec-style for RSpec-style tests
  - When reviewing tests written in RSpec format, invoke gsm-build-best-practice-rspec-style so that they maintain a clean balance of DRYness and readability.

## Domain-specific Guidelines

- ActiveRecord
  - When reviewing ActiveRecord code, invoke gsm-review-code-active-record so that ActiveRecord-specific security and performance guidelines are applied.

## Output

- Report the findings.
