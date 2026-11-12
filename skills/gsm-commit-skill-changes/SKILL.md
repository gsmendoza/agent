---
name: gsm-commit-skill-changes
description: Commit changes to skills, treating skills as executable code instead of documentation. Invoke when committing additions, updates, or fixes to skills.
user_invocable: true
---

# GSM > Commit skill changes

## Instructions

- Follow `/gsm-commit`, but for the commit type, treat skills as executable code instead of documentation.
  - Select code commit types based on the change (e.g., `FEATURE` for a new skill, `ENHANCEMENT` for refining instructions, `BUGFIX` or `CORRECTION` for fixing incorrect behavior, `REFACTORING` for restructuring without behavior changes).

## Background

- Historically, we've saved changes to skills as DOCS, even though I was a bit uncomfortable with it.
