---
name: gsm-lint-ruby-code
description: Invoke when linting Ruby code
user_invocable: true
disable-model-invocation: true
---

# GSM > Lint > Ruby Code

## Workflow

- Determine whether the project's linter is `standardrb` or `rubocop`.

- For modified Ruby files, run the `./gsm-rubocop` script followed by the project's linter.
  - Why: The `./gsm-rubocop` script is a personal linter. The project's linter has higher priority and should run last to take precedence.

