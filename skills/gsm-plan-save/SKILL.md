---
name: gsm-plan-save
description: Invoke after a plan is created, or when the user asks to save a plan. Saves the plan via gsm-general-save.
user_invocable: true
---

# GSM > Plan > Save

## Process

- Save the plan by following the /gsm-general-save skill.
  - Content: the plan from this conversation (default — the most recent plan the agent produced).

## Input

- Default: the plan the agent just produced in this conversation.

## Output

- Plan saved as a file per gsm-general-save (path, naming, link to the file).

## Motivation

- I usually save plans this way because:
  - Reading the plan in the agent CLI is annoying — you have to scroll up to find the start of the printout.

  - Opening Cursor’s default plan file is also annoying:
    - It’s not hyperlinked, so I have to select the path.
    - The path is not prefixed with `/`, so I have to supply it when opening the path in my Markdown viewer.
