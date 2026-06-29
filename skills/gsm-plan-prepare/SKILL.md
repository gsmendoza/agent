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

- For each commit, note the following:
  - Whether we need to apply the following skills:
    - `/gsm-build-tdd`
    - `/gsm-build-lint-ruby`

  - Any best practice skills (prefixed with `gsm-build-best-practice`) that must be run before completing the commit.

  - A reminder to ask the user for the user's approval before proceeding with the next commit.
