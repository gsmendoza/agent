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

- Do a general code review, but be on the lookout for
  - Performance issues
  - Dead code

## Output

- Report findings and then save the review using the /gsm-general-save skill.
