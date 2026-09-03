---
name: gsm-commit
description: Commit changes using a structured commit message format.
user_invocable: true
---

# GSM > Commit

## Goal

- Commit changes using a structured, easy-to-read commit message.

## Instructions

- Format manual commit messages with a header line, a blank line, and a body.

### Header line formatting

- Format the header line as `<TICKET_NUMBER> <TYPE>: <Title>`:
  - `TICKET_NUMBER`: JIRA ticket number (infer from git branch name, or omit if none).

  - `Title`: Short imperative summary of the changes.

  - `TYPE`: Commit type in ALL CAPS. Base on the following decision tree, prioritized from top to bottom:
    - Does the commit affect end users or the development team?
      - If the commit affects end users, does it:
        - Remove an existing feature (e.g., removing CSV export from a dashboard)?
          - `REMOVAL`

        - Fix existing features?
          - Does the fix address:
            - Security issues (e.g., unauthorized access to data or capabilities)?
              - `SECURITY`

            - Performance optimizations or improvements?
              - `PERFORMANCE`

            - Broken or incorrect behavior?
              - Is the broken behavior a production issue? Is it the main goal of the branch's ticket?
                - `BUGFIX`

              - Was the broken behavior introduced in the branch's own implementation? Was it discovered during review of the branch (either by the author or by a reviewer)?
                - `CORRECTION`
                  - Use standard body formatting instead of the bugfix sections.
                    - Why: Unlike a bugfix, a correction fixes an issue that has not been released yet. It doesn't tackle a production issue with documented, actual broken behavior whose cause needs investigating. Adding the bugfix sections to a correction would wrongly imply it fixes a production issue.

        - Apply design or cosmetic changes without changing underlying functionality?
          - `UI`

        - Add or change features?
          - Does the commit add entirely new features or business logic that did not exist before (e.g., adding a dashboard)?
            - `FEATURE`

          - Does the commit refine or extend an existing feature without introducing entirely new systems (e.g., adding a CSV export to a dashboard)?
            - `ENHANCEMENT`

      - If the commit affects the development team, does it:
        - Add boilerplate or skeleton code to support future work (typically generated or copied from an existing feature and not exposed in production by default)?
          - `SCAFFOLD`

        - Apply dependency updates, config changes, or routine tasks?
          - `CHORE`

        - Update documentation only?
          - `DOCS`

        - Update tests only?
          - `TEST`

        - Update code formatting, linting, or whitespace?
          - `STYLE`

        - Improve or clean up code without changing external behavior?
          - `REFACTORING`

### Body formatting

- Structure the body based on the commit type:
  - For standard commits (e.g., `FEATURE`, `ENHANCEMENT`, `REFACTORING`):
    - Write a sentence or short paragraph that summarizes the commit.
    - Do not add a section header.
    - Do not list specific changes.

    - Omit supporting changes unless they are the primary focus of the commit.
      - Examples of supporting changes:
        - Refactorings
        - Test additions
        - User documentation

      - Why: Mentioning supporting changes in the body adds noise.

  - For bugfix commits (`BUGFIX`):
    - Replace the standard description with three sections: `Expected behavior`, `Actual behavior`, and `Cause`.
      - Why: These sections provide the context needed to understand a bugfix.

    - Add headers for these sections, underlined with `--` (since git treats `#` as comments).

- Apply the following formatting to the body:
  - Apply Markdown formatting.
    - Why: I often copy commit messages verbatim as responses to code review feedback.

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
