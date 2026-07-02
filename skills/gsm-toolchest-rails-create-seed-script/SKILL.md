---
name: gsm-toolchest-rails-create-seed-script
description: Invoke when user asks for a personal seed script for a ticket
user_invocable: true
---

# GSM > Toolchest Rails > Create Seed Script

## Goal

- Create a personal seed script and test suite for a specific ticket to enable local testing and demos.

## Expected Outcome

- A runnable wrapper script at `../resources/seeds/<TICKET>.rb` that:
  - Warns the user to run `bin/reset_db` first for a clean database, unless bypassed by setting `SKIP_RESET_DB=1`.
  - Runs the ticket's `import.rb` using `bin/rails runner`.

## Workflow

### 1. Input
- The user will create the initial CSV file at `/home/gsmendoza/workspaces/admin-agencytoolchest/resources/seeds/<TICKET>/import.csv`.

### 2. Implementation
- Create `import.rb` in the ticket directory to load scenario data from `import.csv`.
  - Create a new account specifically for the ticket.
  - Use these standard logins for the account's owner and agent users:
    - `dev-seed-owner@allstate.com`
    - `dev-seed-agent@allstate.com`
    - Why: Standardizing logins across seed scripts avoids having to remember script-specific user logins.

- Create `import_test.rb` in the same directory to test `import.rb`.
  - Do NOT use the `gsm-build-tdd` skill (as its commit process does not apply here).
  - Run the test from the `toolchest-rails` directory using:
    ```sh
    bin/rails test ../resources/seeds/<TICKET>/import_test.rb
    ```
  - Verify script correctness primarily via `import_test.rb`.
    - Avoid testing or executing the wrapper script in the development environment.
    - Why: Verifying with pre-existing records is difficult, and `bin/reset_db` is run before seeding in practice.

- Update `import.csv` if additional columns or rows are needed for seeding.
- Add upload fixture files in the ticket directory (or a subdirectory like `uploads/`) if the ticket requires post-seed file upload in the UI.
- Create the convenience wrapper script `../resources/seeds/<TICKET>.rb`.

### 3. Post-Process
- Print the admin account email for logging in.
- If there are upload fixtures, print instructions on how to upload them in the UI.

## Script & Directory Structure

- **Base Directory**: `/home/gsmendoza/workspaces/admin-agencytoolchest/resources/seeds`
  - **`0-archive/`**: Archive for old/completed ticket folders. Do not touch or copy unless explicitly requested.
  - **`<TICKET>/`** (e.g., `atc_2580_retention_reset_status_on_reimport/`):
    - `import.csv`: Raw scenario data for seeding and guide for manual testing.
    - `import.rb`: Service class to create accounts and import data from `import.csv`.
    - `import_test.rb`: Test for `import.rb` (kept here for easy archiving).
    - `uploads/` (optional): Upload fixtures for manual testing/demos.
  - **`<TICKET>.rb`** (e.g., `atc_2580_retention_reset_status_on_reimport.rb`):
    - Wrapper script to reset database and run the `import.rb` script.

## Directory Context & Environment

- **Working Directory**: `/home/gsmendoza/workspaces/admin-agencytoolchest/toolchest-rails`
- Scripts must run in the context of the Rails app. Reference paths relative to this directory:
  - E.g., `bin/rails runner ../resources/seeds/<TICKET>.rb`
- Private Scope: These seed scripts are personal tools and should not be added to the project's shared `db/seeds`.

## Related Skills

- `gsm-toolchest-rails-bin-over-docker`: For running Rails commands in the development environment.

