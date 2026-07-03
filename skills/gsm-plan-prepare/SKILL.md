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

- For each commit, note:
  - If `/gsm-build-tdd` or `/gsm-build-lint-ruby` should be applied.
  - Any best practice skills (prefixed with `gsm-build-best-practice`) that must run.
  - A reminder to request user approval before proceeding to the next commit.
