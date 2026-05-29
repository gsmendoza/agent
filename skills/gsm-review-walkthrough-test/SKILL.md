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

  - Diff of the current branch against its parent
    - For code reviews, this is usually the default scope.

## Process

- Identify the sections of the test and structure the walkthrough based on these sections.
  - Usually, the test would have three main sections:
    - Setup
    - Action
    - Assert

- For each section, show:
  - The section of the test.
    - Include line numbers so that they're easy to find in the files.

  - An explanation of the test.

  - The exercised code in the order that the section of the test flows through it.
    - Focus on the changes made within the scope given.
      - However, do mention prior changes made outside the scope if the linkages between the code changes are not obvious.

    - Order the exercised code.
      - Focus on the most relevant path through the code.
      - Do not trace every possible call or unchanged layer unless it is needed to explain the behavior.

      - Typical mappings and order per test section
        - Setup
          - Usually code concerned with persistence
            - models
            - migrations

        - Action
          - Present the user's input from top (usually the UI) to bottom (the processing bits):
            - Views
            - Controllers
            - Services
            - Jobs
            - Queries
            - Models

        - Assert
          - Present the output from the bottom to the top (back to the UI):
            - Controllers
            - Views

    - For each exercised code, show
      - The code snippet.
        - Include line numbers so that they're easy to find in the files.

      - An explanation of the code.

## Output

- Use /gsm-general-save to save the walkthrough.
