---
name: gsm-toolchest-rails-create-import-csv
description: Invoke when user asks to create the import.csv for a ticket's personal seed script
user_invocable: true
---

# GSM > Toolchest Rails > Create Import CSV

## Description

- Invoke when user asks to create the `import.csv` for a ticket's personal seed script.

## Goal

- Create the `import.csv` scenario data for a specific ticket, as the first of two steps toward a personal seed script (the second being `gsm-toolchest-rails-create-seed-script`).

## Expected Outcome

- A file at `../resources/tickets/<TICKET_DIR>/seeds/import.csv` (or `../resources/tickets/<TICKET_DIR>/seeds_<name>/import.csv` for multi-seed tickets) containing raw scenario data derived from the ticket's specifications, ready for the user to review before any seed script is built from it.

## Workflow

- Identify the target ticket directory in `../resources/tickets/<TICKET_DIR>/`.
- Create `import.csv` based on the ticket's specifications:
  - For single-seed tickets: create under `../resources/tickets/<TICKET_DIR>/seeds/import.csv`.
  - For tickets with multiple distinct seed scenarios: create under `../resources/tickets/<TICKET_DIR>/seeds_<name>/import.csv` (e.g., `seeds_activities_performance_benchmark/import.csv`), where `<name>` describes the specific scenario with the redundant ticket prefix stripped.

## Directory Structure

- **Base Directory**: `/home/gsmendoza/workspaces/admin-agencytoolchest/resources/tickets/<TICKET_DIR>`
  - **`seeds/`** (single-seed tickets):
    - `import.csv`: Raw scenario data for seeding and guide for manual testing.
  - **`seeds_<name>/`** (multi-seed tickets, e.g., `seeds_activities_performance_benchmark/`):
    - `import.csv`: Raw scenario data for that specific seed scenario.

## Related Skills

- `gsm-toolchest-rails-create-seed-script`: For creating `import.rb`, `import_test.rb`, and the wrapper script from a reviewed `import.csv`.
