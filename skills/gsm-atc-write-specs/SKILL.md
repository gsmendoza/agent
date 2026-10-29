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

- Dataset
  - Define one shared dataset, in a `## Dataset` section before the scenarios, that the scenarios refer to.
    - Why: the seed script can seed the database from the dataset (via `gsm-toolchest-rails-create-import-csv`), so the user can verify the scenarios against test data.
  - Give each record a short, stable label, and group records by type in Markdown tables.
    - For records with a natural name (e.g. agents, households, tags), use real-sounding names in alphabetical order, e.g. `Alice`, `Bob`, `Carol` for agents, or `Anderson`, `Baker` for households.
      - Why: easier to read out loud than `Agent A` or `Tag X`, while the alphabetical order still hints at each record's place in the set.
    - For other records (e.g. quotes, sales), numbered labels like `Quote 1` are fine.
  - Include only the fields the scenarios depend on.
  - In the scenarios, refer to records by label instead of restating their details.
    - Why: keeps the scenarios short, and ties each one to data that can be seeded.

- Scenarios
  - Render the scenarios as Markdown, not as a fenced code block.
    - Why: Markdown is easier to read when copied to Jira.
    - Group scenarios under `## Feature: ...` headings, e.g. `## Feature: Activities by Staff Member table`.
      - Why: uses Gherkin's own grouping keyword, so the Markdown still reads as Gherkin.
    - Give each scenario (and any `Background`) its own heading under its feature, e.g. `### Scenario: ...`.
    - Put each step on its own bullet, with the keyword in bold (e.g. `**Given**`, `**And**`).
      - Why: keeps the keywords scannable on the left margin.
    - Render step data tables as Markdown tables.
    - Flag gaps and assumptions in a blockquote under the step they concern (e.g. `> GAP: ...`) instead of a Gherkin `#` comment.
      - Why: a `#` line renders as a heading in Markdown.

  - Write each `When` and `Then` step as something the user can do or see directly in the app.
    - Why: the user verifies the scenarios by hand in the running app, so a step they can't perform or observe can't be checked.
    - e.g. `Then Alice's row counts Sale 1` can't be verified if the app doesn't let the user drill down from Alice's row to individual sales. Instead, state the values the row should show, derived from the dataset (e.g. `Then Alice's row shows Premium $2,726.56`).

  - Fold contextual detail (e.g., where a feature lives in the UI) into `Given`/`Background` steps rather than a separate prose section.
    - Why: keeps the formal spec self-contained — a reviewer shouldn't need to cross-reference prose outside the Gherkin to know what a step means.

  - When the same behavior surfaces across multiple distinct components or pages, organize scenarios per component instead of one combined feature:
    - Give each component its own `## Feature: <Component>` heading.
    - Extract the rules that apply uniformly across every component into one shared feature (e.g., `## Feature: Shared <behavior>`), stated once. Each component section then only adds scenarios specific to its own presentation, and assumes the shared rules hold.
      - Why: avoids restating the same dedupe/gating/edge-case logic in every section, while still letting a reviewer verify each UI surface independently.

  - When a scenario's purpose is to confirm existing/pre-change behavior still holds (rather than verify new behavior), label it distinctly, e.g. `Scenario (Regression check): ...`.
    - Why: signals to the reviewer that this scenario is a safety net for behavior that already worked, not a new acceptance criterion.

  - Keep scenario titles concise so they fit on a single line.

## Handling gaps

- When the ticket is ambiguous or missing detail needed for a scenario, write a best-effort scenario and flag the assumption or gap inline rather than stopping to ask.
  - Why: this is a draft for review — flagging keeps momentum and gives the domain expert something concrete to correct.

## Output

- Use /gsm-save to save the specs as a file.

- Do not hard-wrap at a fixed column.
  - Why: the user would typically copy the specs to a JIRA ticket, where text is not hard-wrapped.

- Format diagrams and formulas in plain ASCII.
  - Why: the user copies the rendered HTML to Jira tickets, where Mermaid and MathJax aren't supported.
