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

- For each commit, note whether we need to apply the following skills:
  - `/gsm-build-tdd`
  - `/gsm-build-lint-ruby`

- Identify any best practice skills that must be run before completing a commit and note them in the plan.
  - Best practice skills are prefixed with `gsm-build-best-practice`.
