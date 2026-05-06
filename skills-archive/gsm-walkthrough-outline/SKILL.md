---
name: gsm-walkthrough-outline
description: >-
  Builds a branch walkthrough outline from test diffs: Meta, main flow first,
  per-flow Setup / Action (Request + Response) / Assert, and unrelated changes.
  Saves as *-branch-walkthrough-outline.md then applies gsm-save (same body under
  /tmp automatically); run gsm-walkthrough next for citations. Use when the user
  wants a reorganizable outline (nested list or markdown) before a full GSM
  walkthrough, or when they ask for a branch walkthrough outline, test-to-app map
  at high level, or /gsm-walkthrough-outline.
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
3. **App delta (high level)** — Skim `git diff <base> --` for non-test paths that matter to the feature: migrations, views/materialized views, serializers/templates, controllers, domain models. Use this only to name behavior and tie it to flows; do not duplicate the full diff in the outline.
4. **Repository root** — Resolve once with `git rev-parse --show-toplevel` for any paths you mention in the saved file.
5. **Main flow first** — Explicitly decide which flow is the **main** flow for the branch (the primary user- or API-meaningful path the ticket centers on). List that flow **first** among feature flows. Secondary flows follow.

## Output structure

Use headings and bullets the author can rearrange. A practical template:

### Meta

- Base branch, current branch, and a one-line **scope note** (what the test diff actually covers vs what exists only in app code).
- **Main flow** — One line naming which flow section is the main one and why (ticket thread / dominant test).

### Feature flows (vertical slices)

For each **user- or API-meaningful flow** (e.g. a specific endpoint, import path, dropdown), add a section **even if there are no tests** on this branch. State that the flow is **untested** or **manual** when applicable.

**Order:** Put the **main flow** first. Order remaining flows by importance or dependency.

**Cross-cutting work belongs inside flows** — Do **not** use separate top-level sections for “critical” or “supporting” infrastructure. Fold schema/migrations, materialized views, config toggles, shared domain shape, factories, test harness refactors, and similar into the **first flow they materially apply to**, which is **usually the main flow**. When something truly serves multiple flows, mention it under the main flow (or earliest flow) and **cross-reference** briefly in later flows if a one-line reminder helps.

**One bullet per locus (split dense cross-cutting)** — When several files or symbols share one story in a flow (especially the **main flow**), prefer **nested bullets** keyed by path or `Class#method` (one intent line each) over a single sentence that chains many behaviors with semicolons. That keeps the outline scannable and maps **1:1** to walkthrough citations later.

Within each flow that has tests, for **each new or materially changed** test case, use this sequence:

#### a. Setup

- Data and parameters the test prepares.
- When setup **creates or loads records**, surface **model and database** changes that affect that creation (migrations, new columns, validations, associations) **here** if they apply to this setup—not as a detached “infrastructure” list.

#### b. Action

Two parts; describe app changes in the **order** below when tracing the thread (skip layers that do not exist for this stack, e.g. no frontend for a pure API test).

**i. Request (outside in)** — Data received and processed inbound:

1. Frontend (if in scope)
2. Views / templates
3. Controllers (routes, strong params)
4. Jobs
5. Services, queries
6. Models
7. Database, infrastructure (writes, constraints, external systems)

**ii. Response (inside out)** — Data assembled and returned outbound:

1. Database, infrastructure (reads, snapshots)
2. Models
3. Services, queries
4. Jobs
5. Controllers
6. Views / templates
7. Frontend (if in scope)

**Narrative focus:** Emphasize the **domain thread the PR cares about** (e.g. permitted params → persisted attributes → projections → serializers). **De-emphasize** incidental layers unless they are part of the ticket story. When useful, call out **persisted/updated** vs **loaded only for the response**.

#### c. Assert

- Assertions usually **verify the response** (body, status, headers) and tie to **templates or serializers** when relevant.
- When present, add **persistence / side effects** (records, mail, enqueued jobs) as additional assert bullets.

Add a short **Narrative focus** note at the flow level when the branch has a clear primary chain through the stack.

### Unrelated changes

- A section for **diff-backed changes that do not map** to any feature flow above (orphan refactors, tooling-only edits, docs with no test anchor, etc.). Keep it brief; prefer empty if everything ties to a flow.

## Principles (lessons)

- **Main flow leads** — Readers should see the ticket’s center of gravity first; secondary flows and edge paths follow.
- **Infrastructure lives in flows** — Horizontal work (migrations, shared columns, factories) anchors under the flow it enables, typically the main flow, instead of isolated “critical/supporting” buckets.
- **Action vs Assert** — **Action** traces request then response along the stack; **Assert** records what the test observes afterward.
- **Tight coupling to the PR** — Prefer the controller/API → domain/reporting chain the ticket cares about over listing every touched file.
- **Outline vs full walkthrough** — This artifact is for structure and intent; the full `gsm-walkthrough` skill adds per-step citations, fences, and deeper **App change** prose. Save this outline as `{TICKET}-branch-walkthrough-outline.md` (slug **`branch-walkthrough-outline`**); the full walkthrough uses `{TICKET}-branch-walkthrough.md` so both can sit in the same directory.
- **Handoff to gsm-walkthrough** — When expanding to the full document, place prose **directly after each** app citation it describes; follow that skill’s **Prose next to citations** subsection (avoid a single pre-stack paragraph for many fences).

## Deliverable

- Write the outline to disk in the **current working directory** (typically the repo root) as `./<basename>.md`.
- **Filename:** follow the project’s plan-artifact naming rules when a ticket id is available. Use descriptive slug **`branch-walkthrough-outline`** (e.g. `ATC-2363-branch-walkthrough-outline.md` when the branch supplies `ATC-2363`). The sibling full walkthrough from `gsm-walkthrough` uses slug **`branch-walkthrough`**.
- **Automatic [`gsm-save`](/home/gsmendoza/.cursor/skills/gsm-save/SKILL.md)** — Right after the repo file is written, **write the same full markdown body** again under **`/tmp`** using [`gsm-save`](/home/gsmendoza/.cursor/skills/gsm-save/SKILL.md) path and timestamp rules: e.g. **`/tmp/gsm-save-{YYYYMMDD}-{HHMMSS}-branch-walkthrough-outline.md`**. Confirm **both** the repo-relative path and the **`/tmp`** absolute path in the reply (one short line each is enough).

## Optional: outline-only reply

If the user asks for **only** an outline in chat (no repo file), render it as a **nested list** for easy copy and reorganize; still apply **[`gsm-save`](/home/gsmendoza/.cursor/skills/gsm-save/SKILL.md)** by writing that substantive outline markdown to **`/tmp/gsm-save-{YYYYMMDD}-{HHMMSS}-branch-walkthrough-outline.md`**, and confirm that path. Offer to persist the same content under the repo root filename if they want it recorded there too.
