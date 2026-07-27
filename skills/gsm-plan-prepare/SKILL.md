---
name: gsm-plan-prepare
description: Invoke when preparing a plan
user_invocable: true
---

# GSM > Plan > Prepare

## Goal

- Outline a step-by-step implementation plan before writing code.

## Guidelines

- Break down the plan into a sequence of individual atomic, vertical-slice commits.
    - Avoid horizontal slices (e.g., database, API controller, and CSS styling in separate commits) because they result in incomplete, untestable interim commits.
    - Prefer vertical slices that deliver end-to-end testable features. In full-stack apps, combine backend and frontend changes (logic, views, styles, and system tests) so that the user interaction is fully functional.
    - For smaller features, the entire implementation can be a single vertical-slice commit. For larger tasks, slice by user-facing sub-features.

- For each commit:
  - Determine the commit type using `/gsm-general-commit`.
  - Determine if `/gsm-build-tdd`, `/gsm-build-lint-ruby`, or `/gsm-review-code` should be applied.

  - Always yield control to ask for explicit user approval after the commit is made.
    - Why: this allows the user to inspect the commit and its message before the next step begins. The user prefers small iterations over avoiding turn-taking latency.

- Provide a link or path to the plan.
  - Why: so the user can open the plan in an editor.
