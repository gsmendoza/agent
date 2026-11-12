---
name: gsm-toolchest-rails-create-seed-script
description: Invoke when user asks for a personal seed script for a ticket, given a reviewed import.csv
user_invocable: true
---

# GSM > Toolchest Rails > Create Seed Script

## Description

- Invoke when user asks for a personal seed script for a ticket, given a reviewed `import.csv`.

## Goal

- Create a personal seed script and test suite for a specific ticket to enable local testing and demos from an `import.csv` file.

## Input

- An existing, user-reviewed `import.csv` located in `../resources/tickets/<TICKET_DIR>/seeds/` (or `../resources/tickets/<TICKET_DIR>/seeds_<name>/` for multi-seed tickets).
  - Usually created by `gsm-toolchest-rails-create-import-csv`.

## Expected Outcome

- A runnable wrapper script at `../resources/seeds/<TICKET_CONVENIENCE_NAME>.rb` that:
  - Warns the user to run `bin/reset_db` first for a clean database, unless bypassed by setting `SKIP_RESET_DB=1`.
  - Runs the ticket's `import.rb` using `bin/rails runner`.

## Workflow

### Implementation

- Create `import.rb` in the ticket's seed directory (`../resources/tickets/<TICKET_DIR>/seeds/` or `.../seeds_<name>/`) to load scenario data from `import.csv`.
  - Create a new account specifically for the ticket.
  - Use these standard logins for the account's owner and agent users:
    - `dev-seed-owner@allstate.com`
    - `dev-seed-agent@allstate.com`
    - Why: Standardizing logins across seed scripts avoids having to remember script-specific user logins.

- Create `import_test.rb` in the same directory to test `import.rb`.
  - Do NOT use the `gsm-follow-tdd-guidelines` skill (as its commit process does not apply here).
  - Run the test from the `toolchest-rails` directory using:
    ```sh
    bin/rails test ../resources/tickets/<TICKET_DIR>/seeds/import_test.rb
    ```
    (or `.../seeds_<name>/import_test.rb` for multi-seed tickets)
  - Verify script correctness primarily via `import_test.rb`.
    - Avoid testing or executing the wrapper script in the development environment.
    - Why: Verifying with pre-existing records is difficult, and `bin/reset_db` is run before seeding in practice.

- If `import.csv` turns out to need additional columns or rows while implementing `import.rb`, update it directly rather than stopping to ask.
  - Why: this skill assumes the overall scenario was already reviewed; small structural adjustments discovered during implementation don't warrant re-triggering the review step.
- Add upload fixture files in the ticket's seed directory (or a subdirectory like `uploads/`) if the ticket requires post-seed file upload in the UI.
  - Reference fixture files using `__dir__`-relative paths so tests remain portable.
- Create the convenience wrapper script `../resources/seeds/<TICKET_CONVENIENCE_NAME>.rb` pointing to the ticket directory's `import.rb`.

- Update the wrapper script to do the following when run:
  - Print the admin account email for logging in.
  - If there are upload fixtures, print instructions on how to upload them in the UI.

## Script & Directory Structure

- **Ticket Directory**: `/home/gsmendoza/workspaces/admin-agencytoolchest/resources/tickets/<TICKET_DIR>`
  - **`seeds/`** (single-seed tickets) or **`seeds_<name>/`** (multi-seed tickets, e.g., `seeds_activities_performance_benchmark/`):
    - `import.csv`: Raw scenario data for seeding and guide for manual testing.
    - `import.rb`: Service class to create accounts and import data from `import.csv`.
    - `import_test.rb`: Test for `import.rb` (kept here for easy archiving).
    - `uploads/` (optional): Upload fixtures for manual testing/demos.
- **Convenience Wrapper Directory**: `/home/gsmendoza/workspaces/admin-agencytoolchest/resources/seeds`
  - **`0-archive/`**: Archive for legacy shared seed helpers. Do not touch or copy unless explicitly requested.
  - **`<TICKET_CONVENIENCE_NAME>.rb`** (e.g., `atc_2580_retention_reset_status_on_reimport.rb`):
    - Wrapper script to reset database and run the `import.rb` script located in the ticket directory.

## Directory Context & Environment

- **Working Directory**: `/home/gsmendoza/workspaces/admin-agencytoolchest/toolchest-rails`
- Scripts must run in the context of the Rails app. Reference paths relative to this directory:
  - E.g., `bin/rails runner ../resources/seeds/<TICKET_CONVENIENCE_NAME>.rb`
  - E.g., `bin/rails test ../resources/tickets/<TICKET_DIR>/seeds/import_test.rb`
- Private Scope: These seed scripts are personal tools and should not be added to the project's shared `db/seeds`.

## Related Skills

- `gsm-toolchest-rails-create-import-csv`: For creating and getting `import.csv` reviewed before this skill runs.
- `gsm-toolchest-rails-prefer-bin-over-docker`: For running Rails commands in the development environment.
