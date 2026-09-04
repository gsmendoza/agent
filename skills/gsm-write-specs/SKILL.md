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

- Background concepts section, in prose, above the Gherkin block.
  - Define any domain terms or jargon the scenarios rely on, in plain language.
  - Why: lets a non-engineer read the definitions once instead of decoding terminology scenario by scenario.

- The Gherkin block itself, fenced with ```` ```gherkin ```` for syntax clarity.
  - Fold contextual detail (e.g., where a feature lives in the UI) into `Given`/`Background` steps rather than a separate prose section.
    - Why: keeps the formal spec self-contained — a reviewer shouldn't need to cross-reference prose outside the Gherkin to know what a step means.

- Write prose (both the concepts section and any non-Gherkin text) as flowing single lines per bullet or paragraph — do not hard-wrap at a fixed column.
  - Why: the user would typically copy the specs to a JIRA ticket, where text is not hard-wrapped.

## Handling gaps

- When the ticket is ambiguous or missing detail needed for a scenario, write a best-effort scenario and flag the assumption or gap inline rather than stopping to ask.
  - Why: this is a draft for review — flagging keeps momentum and gives the domain expert something concrete to correct.

## Output

- Using /gsm-save, save the specs as a file next to the ticket's other planning docs, under its epic folder (`resources/epics/<epic>/<ticket>/`).
  - Why: this makes it easy for the user to directly modify the file.
