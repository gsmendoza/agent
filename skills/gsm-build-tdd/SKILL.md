---
name: gsm-build-tdd
description: Invoke when applying test-driven development to a change
user_invocable: true
---

## Prerequisites

- The working tree is clean i.e., there are no uncommitted changes.
  - Why: Keeps TDD commits scoped only to the red/green/refactor steps and avoids mixing unrelated diffs or surprise conflicts when creating the temporary branch.
  - If there are, ask the user to clean the working tree e.g., by committing, resetting, or stashing the uncommitted changes.

## Input

- The user expects some change to be made.

## Workflow

- Create and check out a temporary branch based on the current one.
  - Derive the name of the temporary branch from the current one. Just add a suffix.

  - Why: this allows the user to later on squash the temporary branch onto its source branch.

- Repeat this process for every "path" (independently testable behavior or scenario) of the change
  - Create/update the smallest viable test to test-drive the path.

  - Run the test to confirm that it is failing.
    - Verify that it is failing as expected.

  - Commit the failing test. Include in the commit message the relevant excerpt of the test output.
    - Prefer the minimal excerpt that proves the failure: assertion message, expected vs actual, first failing test name — not full tracebacks or unrelated logs unless needed.
    - Why: This would allow the user to verify that the test did fail before a change was applied.

  - Update the code to pass the test.
    - If updating the code requires creating/updating a test for a smaller piece of code, apply this skill (gsm-build-tdd) recursively to that piece of code.
      - Do not create a new branch for this new TDD recursion step.
        - Why: Creating new branches might produce too many branches.

  - Run the test again to confirm that it is now passing.

  - Run other tests relevant to the fix.
    - Why: We want to ensure that the fix didn't break other tests.

  - Commit the change.

  - If the change committed can be refactored,
    - Apply the refactoring.
    - Confirm that the refactoring passes the relevant tests.
    - Commit the refactoring.

## Workflow rules

- Follow /gsm-general-commit for commits generated in this workflow.

## Output

- A branch containing:
  - Commits documenting failing tests and their outputs.
  - Commits applying changes to make those failing tests pass.
  - Optional commits refactoring those changes.

## Post-workflow steps

- The user verifies the temporary branch and merges it to the source branch if correct.
- The user then deletes the temporary branch.
