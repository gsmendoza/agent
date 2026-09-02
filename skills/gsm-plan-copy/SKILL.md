---
name: gsm-plan-copy
description: Invoke when the user asks to copy a plan. Copies the plan via gsm-save.
user_invocable: true
---

# GSM > Plan > Copy

## Process

- Copy the plan by following the [gsm-save](file:///home/gsmendoza/repos/gsmendoza/agent/skills/gsm-save/SKILL.md) skill.
  - Use the plan from the current conversation as the input content (defaults to the most recently produced plan).

## Input

- Default: the plan the agent just produced in this conversation.

## Output

- Plan saved as a file following the [gsm-save](file:///home/gsmendoza/repos/gsmendoza/agent/skills/gsm-save/SKILL.md) guidelines.

## Motivation

- I usually have plans copied this way in Cursor because:
  - Reading the plan in Cursor is annoying — you have to scroll up to find the start of the printout.

  - Opening Cursor’s default plan file is also annoying:
    - It’s not hyperlinked, so I have to select the path.
    - The path is not prefixed with `/`, so I have to supply it when opening the path in my Markdown viewer.
