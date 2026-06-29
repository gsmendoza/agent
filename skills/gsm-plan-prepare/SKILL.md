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

- For each commit, note:
  - If `/gsm-build-tdd` or `/gsm-build-lint-ruby` should be applied.
  - Any best practice skills (prefixed with `gsm-build-best-practice`) that must run.
  - A reminder to request user approval before proceeding to the next commit.
