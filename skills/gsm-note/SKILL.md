---
name: gsm-note
description: Invoke when the user provides information to retain for later in the session. Use for preferences, constraints, and context.
user_invocable: true
---

# GSM > Note

## Goal

- Retain session information the user provides for use in later instructions.

## Input

- Information from the user about the current session.

## Instructions

- Acknowledge and retain the information in conversation context.

- Verify the information if needed.

- Do not make file, code, or other workspace changes.
  - Why: so the user does not have to undo changes that misalign with their direction.
