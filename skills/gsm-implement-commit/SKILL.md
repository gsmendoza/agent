---
name: gsm-implement-commit
description: Implement the next commit from a plan. Invoke when executing or implementing a single commit from an implementation plan.
user_invocable: true
---

# GSM > Implement commit

## Goal

- Implement the next commit from an implementation plan and yield control for user review.

## Background

- Having a skill to implement a single commit from a plan allows the user to inspect the commit and its message before proceeding with the next commit.
  - The user prefers small iterations over avoiding turn-taking latency.

## Input

- An implementation plan, usually generated with `/gsm-plan`.

## Process

- Implement the next commit from the plan:
  - Follow any skills and guidelines specified for the commit in the plan (e.g. `/gsm-apply-tdd`, `/gsm-lint-ruby-code`, `/gsm-follow-code-guidelines`).
  - Commit the changes using `/gsm-commit`.

- Stop after the commit is made and yield control to the user.
  - Why: this allows the user to inspect the commit and its message before proceeding with the next commit.
