---
name: gsm-toolchest-rails-start-session
description: Invoke when starting a work session in the toolchest-rails repo.
user_invocable: true
---

# GSM > Toolchest Rails > Start Session

## Goal

- Start a work session in the `toolchest-rails` repository, setting up ticket context and establishing repository command conventions.

## Process

- Preflight & Ticket Context
  - Invoke `gsm-atc-start-session`.
    - Why: This is the start-session skill for ATC projects (like Toolchest-Rails).

- Command Execution Conventions
  - Follow `gsm-toolchest-rails-prefer-bin-over-docker`.
    - Why: Antigravity regularly misses this skill.
