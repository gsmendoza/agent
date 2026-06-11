---
name: gsm-build-lint-ruby
description: Invoke when linting Ruby code
user_invocable: true
---

# GSM > Build > Lint Ruby

## Workflow

- Run the project's `./gsm-rubocop` script on the modified Ruby files.
  - The gsm-rubocop script is my personal linter.
  - Example: `gsm-rubocop path/to/file.rb`

- Run the project's Ruby linter on the same files.
  - Check if the project uses `standardrb` or `rubocop`.
