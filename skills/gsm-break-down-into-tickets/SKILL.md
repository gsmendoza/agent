---
name: gsm-break-down-into-tickets
description: Break down a requirements doc into tickets and save the results in a CSV file.
user_invocable: true
---

# GSM > Break Down into Tickets

## Description

- Break down a requirements doc into tickets and save the results in a CSV file.

## Instructions

- Given a requirements doc, break it down into tickets. For each ticket, determine each of these attributes:
  - Grouping
    - A generic term to group tickets in the resulting file.

  - UI component
    - The specific view, modal, or widget being created or modified (e.g., "Checkout Modal", "User Table").
    - Use "N/A" for backend or non-UI tickets.

  - Task
    - What will the engineer do when implementing the ticket?
    - Written in imperative tone.

  - Summary
    - A spelled-out version of Task.

  - Surface
    - What code will be touched by the ticket?

  - Complexity
    - Algorithmic and technical difficulty.

    - Values:
      - Low: straightforward CRUD or boilerplate logic.
      - Medium: nontrivial business logic or state management.
      - High: novel architecture, complex concurrency, or intricate algorithms.

  - Breadth
    - Scope across the codebase.

    - Values:
      - Low: isolated to a single file or function.
      - Medium: touches multiple files within a single layer (e.g., several UI components or controllers).
      - High: spans full stack (e.g., DB migrations, backend, API, frontend, or multiple services).

  - Risk
    - Regression blast radius and business criticality.

    - Values:
      - Low: low-visibility or isolated feature with negligible blast radius.
      - Medium: shared feature or non-critical user path where bugs cause minor friction.
      - High: mission-critical path (e.g., auth, payments, data migrations) or high risk of breaking existing behavior.

  - Estimate (T-Shirt)
    - Calculate using a point-based sum of Complexity, Breadth, and Risk (Low = 1, Medium = 2, High = 3):
      - XS: Sum = 3
      - S: Sum = 4–5
      - M: Sum = 6–7
      - L: Sum = 8–9

  - Estimate (Days)
    - Geometric scale mapped to T-Shirt size:
      - 0.5 - Extra small (XS)
      - 1 - Small (S)
      - 2 - Medium (M)
      - 4 - Large (L)

## Output

- Display a markdown summary table in the response.

- With `/gsm-save`, save the results in a CSV file with the above attributes as columns.
