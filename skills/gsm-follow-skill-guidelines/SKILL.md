---
name: gsm-follow-skill-guidelines
description: Ensure skills follow repository conventions and guidelines. Invoke when creating, updating, or reviewing a skill.
user_invocable: true
---

# GSM > Follow Skill Guidelines

## Description

- Ensure skills follow repository conventions and guidelines. Invoke when creating, updating, or reviewing a skill.

## Guidelines

### Frontmatter

- Mark the skill as invocable.
  - In particular, set `user_invocable: true` in the frontmatter.
  - Why: I like being able to use agent CLI's autocomplete feature to automatically invoke skills.

### Content

- Start with a Description section, mirroring the frontmatter description.
  - Why: This ensures the main body of the skill can stand alone even if the frontmatter is stripped.

- Consider that skills in this repo are for personal use and are not intended for general usage.

- Provide rationale for instructions where helpful.
  - Why:
    - The rationale reinforces the importance of the instruction.
    - It provides self-documentation for the skill author.

- Do not overspecify: if an agent can be assumed to have general know-how for the task, there is no need to write it into the skill.
  - Why: By not including general instructions in the skill, it becomes clearer what guidelines and preferences are specific to the user.

### Structure and formatting

- Use headers to define each section.

- Organize skill instructions as a bullet-point outline.
  - Why: This breaks the skill into a hierarchy that helps both humans and agents understand it.

- Use bold and italic formatting sparingly.
  - Why: Bold and italic text can help agents identify important highlights, but heavy formatting makes the text look cluttered.
    - Heavy formatting can be hard for humans to read, especially when the text is viewed in plain ASCII.

### Deprecated patterns

- No longer enforce these patterns:
  - Starting with a Goal/Instructions/Summary section
    - Why: I experimented with various ways to start a skill body. Ultimately, these mostly just restate the frontmatter description, so I reason that it's simplest to just mirror the description.
    - It's acceptable to use these headers (notably Instructions) in subsequent sections.
