---
name: gsm-add-skill
description: Create a skill following repository conventions. Invoke when adding or creating a new skill.
user_invocable: true
disable-model-invocation: true
---

# GSM > Add Skill

## Goal

- Create a skill so an agent can understand when to use it, what task it supports, and how to follow its instructions.

## Input

- Requirements, topic, or instructions for the new skill.

## Process

- Create a skill following the guidelines below.

- Mark the skill as invocable.
  - In particular, set `user_invocable: true` in the frontmatter.
  - Why: the author likes being able to use agent CLI's autocomplete feature to automatically invoke skills.

## Guidelines

### Naming

- `gsm-<optional_namespace>-<command>`
  - `optional_namespace`
    - Will be provided by the user if needed.
  - `command`
    - Written in imperative style (i.e. do something) as a command to the agent.

### Content

- Consider that these skills are for personal use and are not intended for general usage.

- Include a description in the frontmatter explaining what the skill does and when to invoke it.
  - Why: An agent uses the description to determine when the skill is relevant.

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
