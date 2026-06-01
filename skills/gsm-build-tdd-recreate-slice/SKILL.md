---
name: gsm-build-tdd-recreate-slice
description: Recreate one vertical slice from a review branch as a strict TDD sequence. Use when the user is reviewing a branch and wants to see how a specific test or behavior could have been implemented test-first.
user_invocable: true
---

# GSM > Build > TDD > Recreate Slice

## Context

- The user is reviewing an existing branch.

- The user maintains a recreation branch where the review branch is being rebuilt slice by slice.
  - Each invocation creates a temporary branch (via /gsm-build-tdd) that recreates one vertical slice using strict TDD commits.
  - Over time, repeated invocations move the recreation branch closer to the review branch's implementation.

- A "slice" is one independently testable behavior, usually represented by one test or a small set of closely related tests.

## Inputs

- Review branch: the branch being reviewed.

- Recreation branch: the branch where the review branch is being recreated.

- Slice test: the test from the review branch that verifies the slice.

- If any input is unclear, ask the user before changing files.

## Workflow

- Follow /gsm-build-tdd, with the additional constraints in this skill.
  - Check out the recreation branch, then create and check out a temporary branch that will receive the recreated TDD history.
    - Do NOT modify the review branch.

  - Copy only the slice test from the review branch.
  - Run the slice test.
  - Verify and note the expected failure.

  - Commit the copied failing test.
    - Include the minimal relevant test failure excerpt in the commit message.

  - Repeat until the slice test passes:
    - Run the slice test.
    - Note the current failure.

    - Apply exactly one implementation change in exactly one file that moves the code toward fixing that failure.
      - Choose the smallest change that addresses the failure the test is currently reporting.
      - Common example: add one missing method when the failure is an unknown method.
      - Do not copy the full review branch implementation unless that full implementation is the single smallest change required by the current failure.

    - Run the slice test again.
    - Note the next failure, or confirm that the test passes.

    - Commit the implementation change.
      - If the slice test is still failing, include the minimal relevant excerpt of the new failure in the commit message.
      - If the slice test is passing, commit the passing implementation without a failure excerpt.

## Smallest-change rules

- If a conditional is needed, implement only the branch exercised by the slice test.
  - Example: if the slice test covers the happy path, add only the happy-path branch.
    - Do not add the else branch until a separate slice test requires it.

- For migrations, include both `up` and `down`.
  - The test may only verify `up`, but `down` is normally developed with the migration and may be checked manually.

## Workflow rules

- Follow /gsm-general-commit for commits generated in this workflow.
  - For failing-test commits, include the minimal failure excerpt that proves the red step.
  - For implementation commits made while the slice test is still failing, include the minimal failure excerpt that shows the next red step.

- Preserve changes made before this skill invocation. If those changes prevent a clean recreation, ask the user how to proceed.

## Output

- A temporary branch that recreates the selected vertical slice from the review branch as strict TDD history.
  - The branch should contain:
    - The copied slice test as a failing-test commit.
    - One-file, smallest-change implementation commits.
    - Failure excerpts in commit messages when a commit documents a red step.
    - A final state where the slice test passes.
