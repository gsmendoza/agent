---
name: gsm-build-tdd
description: Invoke when applying test-driven development to a change
user_invocable: true
---

## Prerequisites

- The working tree is clean (i.e., there are no uncommitted changes).
  - Why: Keeps TDD commits scoped only to the red/green/refactor steps and avoids mixing unrelated diffs or surprise conflicts when creating the temporary branch.
  - If there are uncommitted changes, ask the user how to handle them (e.g., commit, reset, or stash).

- Confirm that tests relevant to the planned change pass.
  - Why: We want to ensure that the current branch is stable.
    - If there are existing failing tests, ask the user how to handle them.

## Input

- The user expects some change to be made.

## Workflow

- Repeat this process for every "path" (independently testable behavior or scenario) of the change:
  - Create/update the smallest viable test to test-drive the path.

  - Run the test to confirm that it is failing.
    - Verify that it is failing as expected.

  - Update the code to pass the test.
    - If updating the code requires creating or updating a test for a smaller component, recursively apply this skill (gsm-build-tdd) to that component.

  - Run the test again to confirm that it is now passing.

  - Run other tests relevant to the change.
    - Why: We want to ensure that the change didn't break other tests.

  - Commit the change.

  - If the committed change can be refactored:
    - Apply the refactoring.
    - Confirm that the refactoring passes the relevant tests.
    - Commit the refactoring.

## Workflow rules

- Follow /gsm-general-commit for commits generated in this workflow.
