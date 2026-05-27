---
name: gsm-toolchest-rails-create-seed-script
description: Invoke when user asks for a personal seed script for a ticket
user_invocable: true
---

# GSM > Toolchest Rails > Create Seed Script

## Meta

- As this skill implements a new workflow, I'm leaving room for the agent to use its best judgement in building the ticket seed scripts.
  - I'll update this skill as I gain more experience with this workflow.

## Expected outcome

- The user would be able to seed a Toolchest Rails ticket from the toolchest-rails directory:

```sh
bin/rails runner ../resources/seeds/TICKET_NUMBER.rb
```

## Personal seed script structure

- /home/gsmendoza/workspaces/admin-agencytoolchest/resources/seeds
  - 0-archive directory
    - Historical only: for keeping old ticket directories.
    - Don't copy unless specified.

  - TICKET_NUMBER directory
    - Naming convention: atc1234

    - import.rb
      - Service class
      - When called, creates an account for testing the ticket.
      - Loads data from import.csv

    - import.csv
      - Two purposes:
        - Provides the data for seeding the database.
        - Used as a guide when testing and demoing the ticket.

      - Contents
        - Scenario column
          - Describes the scenario being tested by the spreadsheet row.

    - import_test.rb
      - Tests import.rb
      - Needed so that the user and agent can test the service class without having to run the scripts in development.

      - Why is the test file in same directory as import.rb?
        - For convenience. Once I'm done with a ticket, I want to move the import files (with the test) to the archive directory in one go.

  - TICKET_NUMBER.rb
    - Wrapper script. Does
      - Resets the database with `bin/reset_db`
      - Uses `bin/rails runner` to call the ticket's `import.rb` class

## Scope

- resources/seeds are private and personal seeds.
  - They're not shared with the team in toolchest-rails/db/seeds

## Toolchest Rails app as working directory

- The Toolchest Rails app is in /home/gsmendoza/workspaces/admin-agencytoolchest/toolchest-rails.

- The ticket script Ruby code and tests are supposed to run within the context of the Toolchest Rails app. This can be done with a relative path form toolchest-rails. Example:
  - e.g. `bin/rails runner ../resources/seeds/<TICKET_NUMBER>.rb`

## Workflow

### Pre-Process

- The user will archive old ticket directories if they're no longer needed.

### Input

- The user will create the initial CSV file within the seed directory i.e. he'll create the `resources/seeds/<ticket>/import.csv` path.

### Process

- Create import.rb for loading the scenario data from the import.csv file.
  - Test-drive import.rb by creating an import_test.rb file for the class.
    - No need to use /gsm-build-tdd in creating the test file.
      - Why: /gsm-build-tdd has a commit process that is not applicable here.

    - Test command (from toolchest-rails)
      - `bin/rails test ../resources/seeds/<ticket>/import_test.rb`

- Update the import.csv file if it is missing data for seeding the database.

- Create the TICKET_NUMBER.rb convenience script.

### Post-Process

- Print out the account admin email for logging in to the account.

## Related skills

- gsm-toolchest-rails-bin-over-docker
  - For running toolchest-rails commands.
