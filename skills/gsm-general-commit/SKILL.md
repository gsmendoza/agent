---
name: gsm-general-commit
description: Commit changes using a structured commit message format.
user_invocable: true
---

# GSM > General > Commit

## Goal

- Commit changes using a structured, easy-to-read commit message.

## Instructions

- Format manual commit messages with a header line, a blank line, and a body.

### Header line formatting

- Format the header line as `<TICKET_NUMBER> <TYPE>: <Title>`:
  - `TICKET_NUMBER`: JIRA ticket number (infer from git branch name, or omit if none).
  - `TYPE`: Commit type in ALL CAPS. Use one of the following:
    - `FEATURE`: New features or new business logic functionality.
    - `BUGFIX`: Fixes to broken or incorrect behavior.
    - `REFACTORING`: Code improvements or cleanups without changing external behavior.
    - `PERFORMANCE`: Performance optimizations or improvements.
    - `CHORE`: Dependency updates, config changes, or routine tasks.
    - `TEST`: Test-only changes.
    - `DOCS`: Documentation-only changes.
    - `STYLING`: Frontend visual design, CSS, or layout changes.
    - `STYLE`: Code formatting, linting, or whitespace changes.
  - `Title`: Short imperative summary of the changes.

### Body formatting

- Format the body based on the commit type:
  - For standard commits (e.g., `FEATURE`, `REFACTORING`):
    - Write a sentence or short paragraph that summarizes the commit.
    - Do not add a section header.
    - Do not list specific changes.
    - Omit test changes unless they are the primary focus of the commit.
  - For bugfix commits (`BUGFIX`):
    - Replace the standard description with three sections: `Expected behavior`, `Actual behavior`, and `Cause`.
    - Add headers for these sections, underlined with `--` (since git treats `#` as comments).

- Keep the body short and concise.

- Wrap lines at 72 characters.
  - Why: Makes the body easier to read in gitk.

## Examples

### Feature Commit

```
PROJ-123 FEATURE: Add export button to dashboard

Add an "Export" button to the main dashboard view, allowing users to
download their metrics as a CSV file for offline analysis.
```

### Bugfix Commit

```
PROJ-456 BUGFIX: Resolve session timeout redirect loop

Expected behavior
-----------------

Users should be redirected to the login page when their session
expires.

Actual behavior
---------------

Users get stuck in an infinite redirect loop between the home page
and the authentication callback handler.

Cause
-----

The redirect URL logic in the auth middleware did not strip expired
session cookies before redirecting to the login handler.
```
