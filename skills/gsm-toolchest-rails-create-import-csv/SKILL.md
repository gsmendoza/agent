---
name: gsm-toolchest-rails-create-import-csv
description: Invoke when user asks to create the import.csv for a ticket's personal seed script
user_invocable: true
---

# GSM > Toolchest Rails > Create Import CSV

## Goal

- Create the `import.csv` scenario data for a specific ticket, as the first of two steps toward a personal seed script (the second being `gsm-toolchest-rails-create-seed-script`).

## Expected Outcome

- A file at `../resources/seeds/<TICKET>/import.csv` containing raw scenario data derived from the ticket's specifications, ready for the user to review before any seed script is built from it.

## Workflow

- Create `../resources/seeds/<TICKET>/import.csv` based on the ticket's specifications.

## Script & Directory Structure

- **Base Directory**: `/home/gsmendoza/workspaces/admin-agencytoolchest/resources/seeds`
  - **`0-archive/`**: Archive for old/completed ticket folders. Do not touch or copy unless explicitly requested.
  - **`<TICKET>/`** (e.g., `atc_2580_retention_reset_status_on_reimport/`):
    - `import.csv`: Raw scenario data for seeding and guide for manual testing.

## Related Skills

- `gsm-toolchest-rails-create-seed-script`: For creating `import.rb`, `import_test.rb`, and the wrapper script from a reviewed `import.csv`.
