---
name: gsm-meta-proofread-skill
description: Proofread a skill so an agent can understand when and how to use it. Use when reviewing or editing a SKILL.md file for clarity, structure, triggers, and actionable instructions.
user_invocable: true
---

# GSM > Meta > Proofread skill

## Goal

- Proofread a skill so an agent can understand when to use it, what task it supports, and how to follow its instructions.

## Input

- A `SKILL.md` file or draft skill text.

## What to focus on

- Focus on personal guidelines and preferences over general usage.
  - Skills and content here are intended for personal use; they do not need to be designed for general usage.

  - Do not overspecify: if an agent can be assumed to have general know-how for the task, there is no need to write it into the skill.
    - By not including general instructions in the skill, it becomes clearer what guidelines and preferences are specific to the user.

- Bias toward invocable skills.
  - Keep `user_invocable: true` unless the user explicitly wants a non-invocable skill.
  - Do not spend much time deciding whether a skill should be invocable; the default preference is yes.

- Put operational instructions before background context.
  - Keep development notes only when they explain a durable preference.

## Preferred structure

- Use headers to define each section.

- Organize skill instructions as a bullet-point outline.
  - Why: This breaks the skill into a hierarchy that helps both humans and agents understand it.

- Use bold and italic formatting sparingly.
  - Why: Bold and italic text can help agents identify important highlights, but heavy formatting makes the text look cluttered.
    - Heavy formatting can be hard for humans to read, especially when the text is viewed in plain ASCII.

## Current development

- I am experimenting with writing everything, including rules, as invocable skills.
  - Why: Invocable skills may be more portable to other agents because rules apply only to Cursor.

  - CLI ergonomics: Rules do not autocomplete well in Cursor CLI; in the CLI app, `@` is geared toward completing paths and files, not named rules.

  - Simpler defaults: Implementing all skills as invocable simplifies the process of defining them.
    - There is no need to decide whether each skill should be invocable.
    - Making skills non-invocable does not appear to bring much benefit.
