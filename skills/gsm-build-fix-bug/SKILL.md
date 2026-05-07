---
name: gsm-build-fix-bug
description: Invoke when fixing a bug whose cause is already known.
user_invocable: true
---

# GSM > Build > Fix Bug

## Prerequisites

- You already know the cause of the bug.
  - If you don't know yet, ask the user to switch to debug mode to investigate the cause.

- The working tree is clean i.e., there are no uncommitted changes.
  - If there are, ask the user to clean the working tree e.g., by committing, resetting, or stashing the uncommitted changes.

## Workflow

- Create and check out a temporary branch based on the current one.
  - Derive the name of the temporary branch from the current one. Just add a suffix.

  - Why: this allows the user to later on squash the temporary branch onto its source branch.

- Create a test to reproduce the issue.

- Run the test to confirm that it is failing.
  - Verify that it is failing as expected.

- Commit the failing test. Include in the commit message the relevant excerpt of the test output.
  - Why: This would allow the user to verify that the reproduction test did fail before a fix was applied.

- Update the code to fix the issue.
- Run the test again to confirm that it is now passing.

- Run other tests relevant to the fix.
  - Why: We want to ensure that the fix didn't break other tests.

- Commit the fix.

## Output

- A branch containing at least two commits:
  - A commit documenting the failing test and its output.
  - A commit applying the fix.

## Post-workflow steps

- The user verifies the temporary branch and merges it to the source branch if correct.
- The user then deletes the temporary branch.
