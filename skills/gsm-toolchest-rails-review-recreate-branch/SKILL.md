---
name: gsm-toolchest-rails-review-recreate-branch
description: Invoke when the user wants to recreate a branch as atomic vertical slices to understand it better.
user_invocable: true
---

# GSM > Toolchest Rails > Review > Recreate Branch

## Goal

Help the user understand a branch better by recreating it as atomic, vertical slices (one test plus minimal code per slice).

## Input

- Review branch
  - The branch to be reviewed.

- Ticket file and/or PR file
  - Context for prioritizing tests and understanding the change.

- Recreation branch
  - The branch where the review branch will be recreated.
  - Default to the parent of the review branch (usually `main`).

## Process

- Read the ticket and/or PR file for context.

- Test inventory and prioritization
  - Identify the tests in the review branch.
  - Prioritize the tests by relevance to the ticket.

- For each test in the list
  - Propose which test to tackle next. Proceed if the user approves.

  - Use /gsm-toolchest-rails-create-seed-script to generate the seed script for manually testing the scenario.

  - The user manually tests the scenario on the current head of the recreation branch.
    - Why: Allows the user to see the current behavior before the test is implemented.

  - Once the user finishes testing, implement the automated test and minimal production code by copying from the review branch.
    - Constraints
      - Keep the implementation as minimal as possible.
        - Why:
          - The less code, the easier it is for the user to understand.
          - This also allows us to find changes not covered by any of the tests.

      - At the same time, keep the implementation as close as possible to the review branch's code.
        - Why: the closer the code is to the review branch, the easier it is to diff.

    - If the two constraints conflict, prefer keeping the implementation minimal.

  - Run the new test (and any related tests) to confirm it passes.

  - Commit the test slice with /gsm-general-commit.

  - Create a walkthrough of the test with /gsm-review-walkthrough-test.

  - The user reviews the commit with the test walkthrough as a guide.

## Outcome

- As more vertical slices are added, the recreation branch converges toward the review branch.

## Related skills

- /gsm-toolchest-rails-create-seed-script

- /gsm-toolchest-rails-bin-over-docker
  - For running tests.

- /gsm-review-walkthrough-test
- /gsm-general-commit
