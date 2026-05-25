---
name: gsm-review-walkthrough-test
description: Invoke when prompted to write a walkthrough of a test.
user_invocable: true
---

# GSM > Review > Walkthrough test

## Goal

- Write a walkthrough that can allow a user to
  - Follow a test
  - Map the test to the code changes that it is exercising
  - See the code changes in a sequence that shows how input is processed into output.

## Input

- The user will provide the test from which the walkthrough will be produced.

- The user might also provide the scope of the change. Examples:
  - The current commit

  - The current branch
    - For code reviews, this is usually the default scope.

## Process

- Identify the sections of the test. Usually, the test would have three main sections:
  - Setup
  - Action
  - Assert

- Structure the walkthrough using the same section order:
  - Setup
  - Action
  - Assert

- For each section, present:
  - The section of the test.
  - An explanation of what the test is doing, and the reason behind it

  - The exercised code in the order that the test flows through it
    - Focus on the changes made within the scope given.
      - However, do mention prior changes made outside the scope if the linkages between the code changes are not obvious.

    - Typical mappings per test section
      - Setup
        - models
        - migrations

      - Action
        - Reading the user's input down to processing it:
          - Views
          - Controllers
          - Services
          - Jobs
          - Models

      - Assert
        - Presenting the result of the process:
          - Controllers
          - Views

    - Order the exercised code.
        - Base the order on how data is passed:
          - As input from the user,
          - Then as arguments going down one layer of code to another,
          - Then as output going up one layer of code to another.

        - Focus on the most relevant path through the code.
        - Do not trace every possible call or unchanged layer unless it is needed to explain the behavior.

    - For each exercised code
      - Show the code

      - Explain
        - What the code is doing, and
        - The reason behind it.

## Output

- Use /gsm-general-save to save the walkthrough.
