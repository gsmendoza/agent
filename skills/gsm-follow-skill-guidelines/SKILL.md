---
name: gsm-follow-skill-guidelines
description: Ensure skills follow repository conventions and guidelines. Invoke when creating, updating, or reviewing a skill.
user_invocable: true
---

# GSM > Follow Skill Guidelines

## Instructions

- When a skill is changed, ensure that it meets the guidelines specified.

## Guidelines

### Frontmatter

- Mark the skill as invocable.
  - In particular, set `user_invocable: true` in the frontmatter.
  - Why: I like being able to use agent CLI's autocomplete feature to automatically invoke skills.

### Content

- Start with an Instructions section.
  - Why: it should be clear at the start what the agent has to do when the skill is invoked.

- Consider that these skills are for personal use and are not intended for general usage.

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
  - Adding a Goal section
    - Why: I historically started skills with Goal. In hindsight, it's not clear what it should mean: is it the goal for why the skill exists, or the goal the agent has to meet when executing a skill?
