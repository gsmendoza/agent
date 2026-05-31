# README

- This is a repo of Cursor user skills.

## Scope

- Skills and content here are intended for personal use - they don't have to be designed to work for general usage.

## Usage

- ~/.cursor/skills and rules are supposed to symlink to this repo's skills and rules directories.

## Current development

- I'm experimenting with writing everything (including rules) as invocable skills.
  - Why
    - Portability: Experimenting with using these skills with other agents.
      - Rules apply only to Cursor.

    - Annoyance: Rules do not autocomplete well in Cursor CLI; in the CLI app, `@` is geared toward completing paths/files, not named rules.

    - Avoid bikeshedding: implementing all skills as invocable simplifies the process of defining them.
      - No need to bother about whether a skill is invocable or not.
      - Making skills non-invocable does not appear to bring much benefit.

## Writing style

- Use headers to define each section.

- Organize skill instructions as a bullet-point outline.
  - Why: this breaks the skill into a hierarchy that helps both humans and agents understand it.

- Use bold and italic formatting sparingly.
  - Why: bold and italic text can help agents identify important highlights, but heavy formatting makes the text look cluttered.
    - Heavy formatting can be hard for humans to read, especially when the text is viewed in plain ASCII.
