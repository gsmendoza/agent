---
name: gsm-copyedit-skill
description: Copyedit a skill so an agent can understand when and how to use it. Use when reviewing or editing a SKILL.md file for clarity, structure, triggers, and actionable instructions.
user_invocable: true
---

# GSM > Copyedit skill

## Goal

- Copyedit a skill so an agent can understand when to use it, what task it supports, and how to follow its instructions.

## Input

- A `SKILL.md` file or draft skill text.

## Guidelines

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

- Bias toward invocable skills.
  - Why: the author likes being able to use agent CLI's autocomplete feature to automatically invoke skills.

- Consider that these skills are for personal use and are not intended for general usage.

- Do not overspecify: if an agent can be assumed to have general know-how for the task, there is no need to write it into the skill.
  - Why: By not including general instructions in the skill, it becomes clearer what guidelines and preferences are specific to the user.

### Guidelines - Structure

- Use headers to define each section.

- Organize skill instructions as a bullet-point outline.
  - Why: This breaks the skill into a hierarchy that helps both humans and agents understand it.

- Use bold and italic formatting sparingly.
  - Why: Bold and italic text can help agents identify important highlights, but heavy formatting makes the text look cluttered.
    - Heavy formatting can be hard for humans to read, especially when the text is viewed in plain ASCII.
