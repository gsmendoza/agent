---
name: gsm-follow-script-code-guidelines
description: Invoke when planning, writing, or reviewing scripts or automation
user_invocable: true
---

# GSM > Follow > Script > Code Guidelines

## Guidelines

### Robustness

- Verify executable presence using `--version` instead of `which`
  - When checking if an external command/CLI is installed, invoke the command with `--version` (or similar flag) instead of `which`, so that the check is portable across different Unix-like and minimal environment setups.

### Design & Architecture

- Pass configuration parameters and tags as named options
  - When passing optional parameters, base references, or tags to utility/preflight scripts, use named options (e.g. `--baseline TAG` or `-b TAG`) instead of positional arguments, to avoid positional conflicts and ensure a cleaner CLI design.

### Performance

- Avoid redundant git fetch and network operations
  - When performing Git or network operations in scripts, check if helpers or library methods already execute the fetch internally, so that duplicate network requests are avoided.
