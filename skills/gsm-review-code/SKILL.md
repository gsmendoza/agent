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

- See the Guidelines section below for specific rules within these areas.

## Guidelines

### Design & Architecture

- Separate core/library code from execution contexts
  - When writing core or library logic, keep it independent of execution contexts (e.g., CLI, UI, or process control), so that it can be reused across different runtimes.

- Target specific exception classes when rescuing
  - When handling errors with rescue or catch blocks, target the narrowest exception class possible, so that unrelated or unexpected exceptions are not silently swallowed.

- Enforce fail-fast on critical paths and safety checks
  - When executing critical paths or safety checks, do not swallow exceptions silently (e.g., by returning empty values or nil), so that failures are not mistakenly assumed to be successful.

## Output

- Report the findings.
