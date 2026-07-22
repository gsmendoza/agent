---
name: gsm-general-take-note
description: Invoke when the user provides information about the session
user_invocable: true
---

# GSM > General > Take Note

## Goal

- Retain session information the user provides for use in later instructions.

## Input

- Information from the user about the current session.

## Instructions

- Acknowledge and retain the information in conversation context.

- Verify the information if needed.

- Do not make file, code, or other workspace changes.
  - Why: so the user does not have to undo changes that misalign with their direction.
