---
name: gsm-walkthrough-outline
description: >-
  Builds a branch walkthrough outline from test diffs: Meta, critical
  infrastructure, per-flow Setup/Action/Assert, and supporting test changes.
  Saves as *-branch-walkthrough-outline.md; run gsm-walkthrough next for citations.
  Use when the user wants a reorganizable outline (nested list or markdown)
  before a full GSM walkthrough, or when they ask for a branch walkthrough
  outline, test-to-app map at high level, or /gsm-walkthrough-outline.
---

# GSM: Walkthrough outline

Produce a **concise outline** that connects **changed tests** to **application changes**, structured so the author can expand it later into a full walkthrough (for example the `gsm-walkthrough` skill with citations).

This is **not** the full walkthrough: skip exhaustive **Source:/Lines:** blocks unless the user asks for them. Prefer short bullets and clear section boundaries.

## When to use

- The user wants an **outline only**, a **nested list** for reordering, or a lightweight **planning artifact** before writing prose.
- The branch has integration/controller tests where **Setup / Action / Assert** mapping clarifies intent.

## Instructions

1. **Base branch** — Resolve the comparison base (e.g. `main` / `master`) with `git merge-base` or team convention.
2. **Test delta** — Run `git diff <base> -- test/` (list and optionally patch). Prefer identifying **new or modified** test cases via the diff, not by re-reading entire files, so the outline stays tied to what actually changed.
3. **App delta (high level)** — Skim `git diff <base> --` for non-test paths that matter to the feature: migrations, views/materialized views, serializers/templates, controllers, domain models. Use this only to name **infrastructure** and **per-flow** behavior; do not duplicate the full diff in the outline.
4. **Repository root** — Resolve once with `git rev-parse --show-toplevel` for any paths you mention in the saved file.

## Output structure

Use headings and bullets the author can rearrange. A practical template:

### Meta

- Base branch, current branch, and a one-line **scope note** (what the test diff actually covers vs what exists only in app code).

### Critical infrastructure changes

List **horizontal** work that many assertions depend on: schema/migrations, view or snapshot refreshes, dependency or config toggles, **shared** domain shape (e.g. columns projected through reporting or activity pipelines).

Keep this for **truly cross-cutting** mechanics. Do **not** park every feature here.

### Feature flows (vertical slices)

For each **user- or API-meaningful flow** (e.g. a specific endpoint, import path, dropdown), add a section **even if there are no tests** on this branch. State that the flow is **untested** or **manual** when applicable.

Within each flow that has tests, for **each new or materially changed** test case:

- **Setup** — Data and parameters the test prepares.
- **Action** — The test’s driving interaction (e.g. HTTP request, job, click) plus the **application thread that matters for the PR**:
  - Entry points: controller/route, strong params, service or job if that is where the branch focuses.
  - **Primary narrative:** emphasize how the change propagates along the **domain thread the PR cares about** (for example: persisted attributes on core records → activity or reporting projections → serializers). **De-emphasize** incidental models unless they are part of the PR story.
  - **Reads vs writes:** state what is **persisted or updated** vs what is **loaded for the response** when that distinction helps.
- **Assert** — Split when useful:
  - **Response / serialization:** assertions on the parsed response body; tie them explicitly to **templates or serializers** that build that JSON/HTML (these checks are effectively exercising the view/serialization layer).
  - **Persistence / side effects:** direct checks on records, mail, jobs, etc., when present.

Add a short **Narrative focus** note at the document or section level if the branch has a clear **primary story** (e.g. “controller/permitted params → policy rows → activity views → revenue models”). In **Action**, foreground that chain; mention other touched models only when relevant.

### Supporting infrastructure changes

Factories, test support, schema-only comment updates in tests, harness refactors—**without** new test cases. Group briefly.

## Principles (lessons)

- **Flows ≠ infrastructure** — A dedicated endpoint or UI path (e.g. lookups for a dropdown) is a **vertical slice**, not necessarily “infrastructure,” even when untested.
- **Action vs Assert** — **Action** describes what the test drives and what the server does on the way in (including the PR’s persistence chain). **Assert** describes what is observed afterward; **response shape** belongs here and maps naturally to **serialization/templates**.
- **Tight coupling to the PR** — Prefer tracing **controller (or API) changes → the domain/reporting layer the ticket cares about** over listing every model the stack touches.
- **Outline vs full walkthrough** — This artifact is for structure and intent; the full `gsm-walkthrough` skill adds per-step citations, fences, and deeper **App change** prose. Save this outline as `{TICKET}-branch-walkthrough-outline.md` (slug **`branch-walkthrough-outline`**); the full walkthrough uses `{TICKET}-branch-walkthrough.md` so both can sit in the same directory.

## Deliverable

- Write the outline to disk in the **current working directory** (typically the repo root) as `./<basename>.md`.
- **Filename:** follow the project’s plan-artifact naming rules when a ticket id is available. Use descriptive slug **`branch-walkthrough-outline`** (e.g. `ATC-2363-branch-walkthrough-outline.md` when the branch supplies `ATC-2363`). The sibling full walkthrough from `gsm-walkthrough` uses slug **`branch-walkthrough`**.
- Confirm the saved path in the reply.

## Optional: outline-only reply

If the user asks for **only** an outline in chat (no file), render it as a **nested list** for easy copy and reorganize; still offer to persist the same content to a file if they want it recorded.
