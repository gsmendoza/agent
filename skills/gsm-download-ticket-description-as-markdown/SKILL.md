---
name: gsm-download-ticket-description-as-markdown
description: Download a Jira ticket's description as a Markdown file in the ticket's folder. Invoke when asked to download, save, or snapshot a ticket's description locally.
user_invocable: true
---

# GSM > Download Ticket Description as Markdown

## Description

- Download a Jira ticket's description as a Markdown file in the ticket's folder. Invoke when asked to download, save, or snapshot a ticket's description locally.

## Script

- [`scripts/download_ticket_description.rb`](scripts/download_ticket_description.rb)
  - Run it from the repository (e.g. `toolchest-rails`), so it can read `.env` and the current branch.
  - Arguments
    - `TICKET_KEY` (optional): defaults to the ticket prefix of the current branch, e.g. `ATC-3095`.
    - `--stdout`: print the Markdown instead of saving it.
  - Prints the saved file's path.

## Behavior

- Fetches the ticket with `jira issue view <KEY> --raw`, authenticating with `JIRA_API_TOKEN` from the environment or `.env`.
- Converts the description from Atlassian Document Format to Markdown.
  - Why: `pandoc` isn't installed, and the `jira` CLI's `--plain` output is wrapped terminal text, not Markdown.
- Starts the file with the ticket key, summary, and a link to the ticket, and ends it with a list of attachment links.
  - Inline images and files become `[Attachment: <name>]` placeholders, since Jira's media IDs don't map to attachment URLs.
- Saves to the ticket's folder under `GSM_TICKETS_PATH` (default `../resources/tickets`), creating it if needed, as `<key>-ticket-description-<YYYYMMDD-HHMM>.md`.
  - Why: matches `gsm-save` naming, and the timestamp keeps earlier snapshots when the ticket changes.

## Output

- Give the user the saved file's path.
