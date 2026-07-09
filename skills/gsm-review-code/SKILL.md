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

- Perform a general code review, focusing on:
  - Correctness
  - Performance
  - Security

  - Design & Architecture
    - Separation of concerns
      - Keep core/library code independent of execution contexts (e.g. CLI, UI, process control).

    - Method purity
      - Prefer pure queries/transformations; push side effects to the caller or wrapper methods.

    - Exception handling
      - Ensure rescue/catch clauses target the correct exception class scope.
      - On critical paths or safety checks, enforce fail-fast: do not swallow exceptions silently (e.g., by returning `[]` or `nil`).
      - Treat failed safety verifications as failures that block the action, rather than assuming success.

## Output

- Report the findings.
