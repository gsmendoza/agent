---
name: gsm-atc-draft-initial-pr
description: Generate and save a local draft of an initial pull request for an ATC ticket branch.
user_invocable: true
---

# GSM > ATC > Draft Initial PR

## Description

- Generate and save a local draft of an initial pull request for an ATC ticket branch.

## Workflow

### 1. Retrieve ticket asset links

- Check the remote Google Drive destination (`narralabs:home/tickets`) for uploaded demo videos and seed script bundles (from `/gsm-atc-upload-ticket-assets`).

- Locate the remote ticket directory matching `<TICKET_ID>*` or the branch name:
  ```bash
  rclone lsf "narralabs:home/tickets" --dirs-only
  ```

- Inside the remote ticket directory (`narralabs:home/tickets/<ticket-folder>`):
  - Find the demo video (`*demo*.mp4` or `*.mp4`, choosing the most recent if multiple exist):
    ```bash
    rclone link "narralabs:home/tickets/<ticket-folder>/<demo-file>"
    ```

  - Find the seed script bundle directory (e.g. `atc_<ticket_num>_*` or snake-cased branch name):
    ```bash
    rclone link "narralabs:home/tickets/<ticket-folder>/<seed-bundle-dir>"
    ```

- If an asset is not found on Google Drive, fall back to `TODO` for that section.

### 2. Compose the PR draft

- Generate the PR title using the header line format from `/gsm-commit` (`<TICKET_NUMBER> <TYPE>: <Title>`).
- Format the draft with the title as the top-level heading followed by the PR template sections:

```markdown
# <TICKET_NUMBER> <TYPE>: <Title>

## Ticket

https://agencytoolchest.atlassian.net/browse/<TICKET_ID>

## Summary

<Summary from the branch's commit messages. Prefer a bulleted list over paragraphs.>

## Additional changes

<Changes outside the ticket scope or that cross ticket boundaries. Omit this section if none.>

## Demo/Screenshots

<Google Drive link on its own line, or TODO>

## Seed Data

<Google Drive link on its own line, or TODO>
```

- Limit the summary to what the branch's commit messages already say; do not add extra detail.
  - Why: Keeps the PR description aligned with the commit history and avoids redundant elaboration.

### 3. Save the draft

- Invoke `/gsm-save` with the suggested slug `pr-draft-<ticket-id>` to save the draft locally.
  - Provide the user with the generated draft and the link to the saved file.
