---
name: gsm-write-specs
description: Write a ticket's specs as Gherkin scenarios for a non-engineer domain expert to verify. Invoke when asked to formalize, write, or rewrite a ticket's specs/acceptance criteria in Gherkin/BDD format.
user_invocable: true
---

# GSM > Write Specs

## Goal

- Turn a ticket's spec into Gherkin scenarios a non-engineer domain expert can read and verify against the running app, without needing to read code.

## Input

- Default: the current ticket's spec/acceptance criteria (from the JIRA ticket description, or as relayed in conversation).

## Structure

- Concepts
  - Define any domain terms or jargon the scenarios rely on, in plain language.
    - Why: lets a non-engineer read the definitions once instead of decoding terminology scenario by scenario.

  - When concepts split naturally into distinct categories (e.g., domain/business rules vs. the UI components that surface them), flatten them into separate `##` sections instead of one combined "Concepts" list, and drop the "Concepts" header.
    - Why: a reader scanning for "what's the rule" vs. "where does this show up" shouldn't have to sort a flat list to tell them apart.

  - Do not hard-wrap at a fixed column.
    - Why: the user would typically copy the specs to a JIRA ticket, where text is not hard-wrapped.

- Scenarios
  - The Gherkin block itself, fenced with ```` ```gherkin ```` for syntax clarity.
  - Fold contextual detail (e.g., where a feature lives in the UI) into `Given`/`Background` steps rather than a separate prose section.
    - Why: keeps the formal spec self-contained — a reviewer shouldn't need to cross-reference prose outside the Gherkin to know what a step means.

  - When the same behavior surfaces across multiple distinct components or pages, organize scenarios per component instead of one combined feature:
    - Give each component its own `## Scenarios - <Component>` heading and its own fenced Gherkin block.
    - Extract the rules that apply uniformly across every component into one shared section (e.g., `## Scenarios - Shared <behavior>`), stated once. Each component section then only adds scenarios specific to its own presentation, and assumes the shared rules hold.
      - Why: avoids restating the same dedupe/gating/edge-case logic in every section, while still letting a reviewer verify each UI surface independently.

  - When a scenario's purpose is to confirm existing/pre-change behavior still holds (rather than verify new behavior), label it distinctly, e.g. `Scenario (Regression check): ...`.
    - Why: signals to the reviewer that this scenario is a safety net for behavior that already worked, not a new acceptance criterion.

## Handling gaps

- When the ticket is ambiguous or missing detail needed for a scenario, write a best-effort scenario and flag the assumption or gap inline rather than stopping to ask.
  - Why: this is a draft for review — flagging keeps momentum and gives the domain expert something concrete to correct.

## Output

- Using /gsm-save, save the specs as a file next to the ticket's other planning docs, under its epic folder (`resources/epics/<epic>/<ticket>/`).
  - Why: this makes it easy for the user to directly modify the file.
