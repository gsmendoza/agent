---
name: gsm-copyedit-skill
description: Copyedit a skill so an agent can understand when and how to use it. Use when reviewing or editing a SKILL.md file for clarity, structure, triggers, and actionable instructions.
user_invocable: true
disable-model-invocation: true
---

# GSM > Copyedit skill

## Goal

- Copyedit a skill so an agent can understand when to use it, what task it supports, and how to follow its instructions.

## Input

- A `SKILL.md` file or draft skill text.

## Guidelines

- Follow guidelines from /gsm-add-skill.

- Focus only on the uncommitted changes.
  - Why: changing copy that is already committed clutters the skill's diff, making it harder for the author to review the changes.

- Keep instruction rationale when provided.
  - Why:
    - The rationale reinforces the importance of the instruction.
    - It provides self-documentation for the skill author.

- Avoid overwriting the user's changes in version control.
  - In particular,
    - If the user's changes are staged, keep your changes unstaged.

  - Why: we want the author to be able to use `git diff` to see what you've changed from his changes.

