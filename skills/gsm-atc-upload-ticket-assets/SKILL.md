---
name: gsm-atc-upload-ticket-assets
description: Copy a ticket's demo video and seed script bundle to work Google Drive. Invoke when uploading demo videos and seed script bundles for an ATC ticket.
user_invocable: true
---

# GSM > ATC > Upload Ticket Assets

## Goal

- Copy a ticket's demo video and seed script bundle from local resources to work Google Drive (`narralabs:home/tickets/<ticket-folder>`).

## Prerequisites & Environment

- `rclone` installed and configured with the `narralabs:` remote.
  - The script verifies `rclone --version` at execution time.
- Google Drive credentials set via environment variables or loaded from repository `.env`:
  - `GSM_NARRALABS_GOOGLE_DRIVE_CLIENT_ID`
  - `GSM_NARRALABS_GOOGLE_DRIVE_CLIENT_SECRET`
- Resource path definitions:
  - `GSM_RESOURCES_PATH` (defaults to `../resources`)
  - `GSM_TICKETS_PATH` (defaults to `../resources/tickets` or `$GSM_RESOURCES_PATH/tickets`)
  - `GSM_SEEDS_PATH` (defaults to `../resources/seeds` or `$GSM_RESOURCES_PATH/seeds`)

## Script

- Backed by the Ruby automation script:
  - [`scripts/upload_ticket_assets.rb`](scripts/upload_ticket_assets.rb)

### Available Script Options

- `-b`, `--branch BRANCH`: Specify git branch (defaults to current git branch).
- `-d`, `--dry-run`: Preview matched files and rclone commands without performing network transfers.
- `--resources-path PATH`: Override base resources path.
- `--tickets-path PATH`: Override tickets path.
- `--seeds-path PATH`: Override seeds path.
- `--remote REMOTE`: Override rclone destination (defaults to `narralabs:home/tickets`).

## Workflow

### 1. Preflight

- Confirm the working directory is the repository (e.g., `toolchest-rails`) or supply the appropriate `--branch` and resource path flags.
- If previewing before executing, run with `--dry-run`:
  ```sh
  /path/to/upload_ticket_assets.rb --dry-run
  ```

### 2. Execute Asset Upload

- Run the upload script:
  ```sh
  /path/to/upload_ticket_assets.rb
  ```

### 3. File Discovery Logic

- **Ticket Issue & Directory**:
  - Extracted from branch prefix (e.g. `ATC-2871`).
  - Located at `<tickets-path>/<branch-name>` (or folder matching `<ticket-issue>*`).
- **Demo File**:
  - Matches `*demo*.mp4` (or `*.mp4`) in the ticket directory.
  - If multiple demo files exist, selects the most recently modified file.
- **Seed Script Bundle**:
  - Matches `atc_<ticket_num>_*` directory under `<seeds-path>`, falling back to exact snake-cased branch name.
  - Copies the seed directory bundle itself into the remote ticket folder.
- **Resilience**:
  - At least one asset (demo or seed bundle) must exist. If either is missing, a warning is emitted and the remaining asset is uploaded.

### 4. Verification

- Inspect the output summary printed by the script:
  - Confirms uploaded demo file and remote path.
  - Confirms uploaded seed script bundle and remote path.
  - Confirms remote destination directory under `narralabs:home/tickets/<ticket-folder>`.
