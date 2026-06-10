---
name: gsm-build-lint-ruby
description: Invoke when linting Ruby code
user_invocable: true
---

# GSM > Build > Lint Ruby

## Workflow

- Run `gsm-rubocop` on the modified Ruby files.
  - Example: `gsm-rubocop path/to/file.rb`

- Run the project's Ruby linter on the same files.
  - Check if the project uses `standardrb` or `rubocop`.
