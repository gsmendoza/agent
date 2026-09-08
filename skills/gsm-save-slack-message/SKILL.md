---
name: gsm-save-slack-message
description: Invoke when saving the agent's response formatted for Slack
user_invocable: true
disable-model-invocation: true
---

# GSM > Save Slack message

## Goal

- Save the agent's response formatted for compatibility with Slack messages.

## Input

- Follow /gsm-save.

## Output

- Follow /gsm-save.

## Guidelines

- Follow /gsm-save for saving the response.

### Guidelines - Slack Formatting

- Override standard Markdown formatting to be compatible with Slack messages:
  - **Headers**: Use bold text instead of Markdown headers (`#`, `##`, `###`).
    - Example: `*Section title*` instead of `## Section title`
    - Why: Slack message formatting does not support Markdown header syntax.

  - **Bold**: Use paired single asterisks (`*text*`) instead of double asterisks (`**text**`).
    - Example: `*bold text*`
    - Why: Slack uses single asterisks for bold formatting.

  - **Indentation**: Use 4 spaces for indentation.
    - Example: Indent nested list items with 4 spaces instead of 2.
    - Why: Slack parses nested lists properly with 4-space indentation.
