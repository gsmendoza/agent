---
name: gsm-atc-save
description: Invoke when saving the agent's response to a ticket's artifact folder in an ATC project.
user_invocable: true
---

# GSM > ATC > Save

## Goal

- Save the agent's response as a file in the current ticket's artifact folder, instead of the default `gsm-save` destination.

## Process

- Ticket and epic context
  - Identify the ticket number from the current branch name.
  - Use `jira` CLI to fetch the ticket details and its parent epic.
    - Use `JIRA_API_TOKEN` from `.env` to authenticate.

- Artifact storage
  - Find or create the folder for the epic in `../resources/epics/`.
  - Under the epic's folder, find or create the folder for the ticket.
    - Why: Keeps every artifact for a ticket in one place, alongside artifacts for sibling tickets under the same epic.

- Invoke `/gsm-save`, overriding its default output path with the ticket's artifact folder.
