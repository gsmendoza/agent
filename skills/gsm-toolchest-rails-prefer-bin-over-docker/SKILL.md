---
name: gsm-toolchest-rails-prefer-bin-over-docker
description: Invoke when running rails commands and gems in toolchest-rails repo, like Rails tests, console, migrations, rake, linters.
user_invocable: true
---

# GSM > toolchest-rails > Prefer Bin Over Docker

## Summary

- Where the current repo is toolchest-rails
  - When running Rails commands (tests, generators, console, migrations where applicable, etc.),
    - Prefer **`bin/rails` on the host** over:
      - `bundle exec rails`
      - `bundle exec dc-rails`
      - `docker compose run` / `docker compose exec` (or equivalents that run Rails inside Compose services)

  - Similarly, where the project has a binstub for an executable (e.g. `bin/rake`, `bin/standardrb`),
    - Prefer **`bin/<tool>` on the host** over `bundle exec` or Compose.

## Reason

- Tends to be faster than running the same commands **via Docker Compose** (inside a container) when the stack is reachable from the host anyway.
- Allows running scripts that live outside toolchest-rails, such as `/home/gsmendoza/workspaces/admin-agencytoolchest/resources/seeds`.
- In development we use Docker mainly for the **local web server** and backing **services** (for example the database). Those services are often reachable from the host, so one-off CLI work does not have to go **through containers** unless the task needs the Compose environment.

## Examples

```bash
bin/rails test
bin/rails test test/models/user_test.rb
bin/rails test test/models/user_test.rb:42
```

Pass the same arguments, paths, line filters, and framework options you would after `rails` or `rake`.

## Exceptions

- When a task **explicitly requires the Docker Compose environment** (behavior, paths, or dependencies that only apply inside a container):
  - Follow the project's Compose-based workflow (`docker compose …` or **`bin/dc-*` binstubs** such as **`bin/dc-rails`**).
    - Prefer those project binstubs over ad hoc `bundle exec dc-rails` or raw `compose` invocations.

  - See the project README when unsure.
