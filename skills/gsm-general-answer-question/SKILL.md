---
name: gsm-general-answer-question
description: Invoke when the user wants the agent to answer a question without making workspace changes. Use for explanations, comparisons, and research-only requests.
user_invocable: true
---

# GSM > General > Answer Question

## Goal

- Answer the user's question without making workspace changes.

## Input

- The user's question.

## Instructions

- Do not make file, code, or other workspace changes.
  - Why: so the user does not have to undo changes that misalign with their direction.
