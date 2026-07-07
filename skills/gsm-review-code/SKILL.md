---
name: gsm-review-code
description: Invoke when user asks for a code review
user_invocable: true
---

# GSM > Review > Code

## Input

- Default: diff of the current branch against its parent branch

- User might provide a different scope for the review. Examples:
  - Unstaged commits
  - The last commit

## Process

- Perform a general code review, focusing on:
  - Correctness
  - Performance
  - Security

## Output

- Report the findings.
