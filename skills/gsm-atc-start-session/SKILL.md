---
name: gsm-atc-start-session
description: Invoke when starting a new session based on the current branch in an ATC project.
user_invocable: true
---

# GSM > ATC > Start Session

## Goal

- Start a work session for the repository's current branch and set up the directory structure for its epic and ticket artifacts.

## Process

- Preflight
  - Warn if the session name does not match the repo's current branch.

- Ticket and epic context
  - Identify the ticket number from the current branch name.
  - Use `jira` CLI to fetch the ticket details and its parent epic.
    - Use `JIRA_API_TOKEN` from `.env` to authenticate.

- Artifact storage
  - Find or create the folder for the epic in `../resources/epics/`.
  - Under the epic's folder, find or create the folder for the ticket.
