---
name: gsm-plan
description: Invoke when preparing a plan
user_invocable: true
---

# GSM > Plan

## Goal

- Write a step-by-step implementation plan before writing code.

## Input

- Usually a ticket with specs written using `/gsm-write-specs`.

## Guidelines

- In the plan:
  - Break down the ticket into a sequence of individual atomic, vertical-slice commits.
    - Prefer vertical slices that deliver end-to-end testable features. In full-stack apps, combine backend and frontend changes (logic, views, styles, and system tests).
      - Why: This results in a complete and testable commit.
      - Why not horizontal slices (e.g., database, API controller, and CSS styling in separate commits):
        - They result in incomplete, untestable interim commits.

  - For each commit:
    - Indicate the commit type based on `/gsm-commit`.

    - List which of these skills need to be invoked when implementing the commit:
      - Skills to consider:
        - `/gsm-apply-tdd`
        - `/gsm-lint-ruby-code`
        - `/gsm-follow-code-guidelines` and other `/gsm-follow-*-guidelines` skills.

      - Why: this allows the user to evaluate how well the agent is able to find the right skills and guidelines for the commit.

- Save the plan using `/gsm-save` and provide a link or path to it.
  - Why: so the user can read the plan in an editor.
