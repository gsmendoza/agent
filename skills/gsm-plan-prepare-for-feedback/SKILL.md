---
name: gsm-plan-prepare-for-feedback
description: Invoke when preparing a plan for assessing and addressing PR or review feedback
user_invocable: true
---

# GSM > Plan > Prepare > For Feedback

## Goal

- Prepare a plan for assessing and addressing feedback.

## Input

- Feedback from the user. Can be:
  - GitHub PR feedback
    - Usually saved as HTML.

  - Local agent review
    - Usually saved as Markdown.

## Process

- Assess whether each item of feedback is valid.
  - Also consider any responses the user (gsmendoza) has left on the feedback file.
    - This is especially important for GitHub PR feedback.

  - If an item is invalid, note in the plan that it will be skipped and why.
    - Why: so the user can tell the item was assessed and skipped, not overlooked.

- Invoke `/gsm-plan-prepare` to prepare a new plan addressing the feedback.
  - Plan preferences:
    - Create one commit per feedback item.
      - Why: so the user can verify each item's resolution.

    - Create a new plan instead of updating the original plan for the ticket.
      - Why: so the user can separate the ticket's original tasks from its post-review revisions.
