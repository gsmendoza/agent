---
name: gsm-review-code
description: Invoke when user asks for a code review
user_invocable: true
---

# GSM > Review > Code

## Input

- Git diff to review.
  - Default: Diff of the current branch against its parent branch.
    - Parent branch: the branch this one was cut from (e.g. an upstream feature branch in a stack, not the repo default branch).
    - Why: Scope the review to commits on this branch only, not work already covered on the parent.

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
  - Robustness

- Check if the code being reviewed meets [gsm-follow-code-guidelines](file:///home/gsmendoza/repos/gsmendoza/agent/skills/gsm-follow-code-guidelines/SKILL.md).
  - Apply general guidelines and any relevant domain-specific guidelines (ActiveRecord, Scripts, Presentation).

## Output

- Report the findings.
