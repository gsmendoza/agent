---
name: gsm-follow-tdd-guidelines
description: Ensure changes adhere to test-driven development guidelines. Invoke when planning, writing, or refactoring code using outside-in TDD.
user_invocable: true
---

# GSM > Follow > TDD Guidelines

## Description

- Ensure changes adhere to test-driven development guidelines. Invoke when planning, writing, or refactoring code using outside-in TDD.

## Guidelines

### Prerequisites

- The working tree is clean (i.e., there are no uncommitted changes).
  - Why: Ensures the TDD cycle starts from a clean baseline and avoids mixing preexisting uncommitted diffs with the new implementation.
  - If there are uncommitted changes, ask the user how to handle them (e.g., commit, reset, or stash).

- Confirm that tests relevant to the planned change pass.
  - Why: We want to ensure that the current branch is stable.
  - If there are existing failing tests, ask the user how to handle them.

### Constraints

- When in the process of test-driving development, the agent should limit itself to changing either a single test or single unit of code at a time.
  - Why: this prevents the anti-pattern of writing either all of the tests, or all of the implementation code, in a single step.
    - Doing so negates the main benefit of TDD: letting the tests determine what is implemented, which generally ensures that the implementation is minimal, that is, including only the code needed to pass the tests.

  - Clarifications:
    - A single test
      - A "test" or "it" block
      - Not: an entire test file

    - A single unit of code
      - When unit-testing, the method being tested.
      - When system-testing, the public unit where the test failure comes from.
      - For non-method layers (e.g. route entries in `config/routes.rb`, view templates, database migrations), each layer change counts as a single unit of code when addressing a failure in that layer.

      - The agent is allowed to change internal code supporting the unit being tested, as long as the internal code is not directly testable itself.
        - Examples of internal code that is not testable:
          - Private methods
          - Constants

    - Refactoring
      - Refactoring must also proceed incrementally (one unit or extraction at a time) with test verification between changes.

### Cleanup

- Remove stepping-stone tombstone tests
  - If any tests were written solely to test-drive the removal, deprecation, or refactoring of functionality, delete those tests once the removal is verified.
    - Follow the tombstone guideline in `/gsm-follow-code-guidelines`.
    - Why: While a negative test (e.g. asserting an old element or route is gone) can be useful as temporary scaffolding during the TDD red-green cycle, keeping it permanently creates a tombstone that clutters the test suite and memorializes dead architecture.
    - Clarification: Do not delete active negative contracts (e.g., tests verifying authorization boundaries, input validations, or active business constraints). Only delete tests whose sole purpose was verifying that a retired feature no longer exists.

## Examples

### Outside-in TDD run

- As a prerequisite, the agent runs all the relevant tests for the new feature. They pass, ensuring a stable baseline.
- The agent then updates a single system test. It fails on a view template.
- The agent assesses that it's not valuable to create a unit test for the view.
- The agent proceeds to update the view.
- The agent runs the system test again. It fails on a controller action.
- The agent decides to add a test for the controller action. The test fails on a call to a model method.
- The agent assesses that it's not valuable to create a unit test for the model method.
- The agent proceeds to update the model method.
- The agent adds constants and private methods supporting the model method, since these won't be unit-tested.
- The agent runs the controller action test. This time it passes.
- The agent decides to refactor the model method and its supporting code.
- The agent runs the controller action test again. This time it passes.
- The agent runs the system test again. It also passes.
- The agent repeats this cycle for each remaining planned scenario.
- The agent prunes any stepping-stone tests created specifically to drive removals.
- Once all scenarios pass and stepping-stone tests are pruned, the agent runs all relevant test suites to confirm no regressions.
