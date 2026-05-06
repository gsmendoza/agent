---
name: gsm-create-rule
description: >-
  Guides authoring and review of Cursor rule files (.mdc) and optional
  pairing with thin skills that reference rules via Apply @. Use when
  creating or substantially editing a rule, changing rule scope metadata
  (alwaysApply or globs), adding a skill stub that points at a rule, or
  auditing rule layout under this repository's rules/ tree.
---

# gsm-create-rule

## Overview

This skill **extends `gsm-create-skill`**: the same expectations apply to
structure, clarity, anti-rationalization, and evidence-backed checks, but the
artifact is a **rule** (`.mdc`) whose canonical copy in **this repository**
lives under `rules/`. Read **`gsm-create-skill`** for the generic workflow and
section pattern; use **this skill** for paths, rule frontmatter, activation
scope, and `@` pairing with `SKILL.md`.

## When to Use

- Adding a new `*.mdc` rule or rewriting an existing one (structure, scope, or
  major content).
- Changing whether a rule is always on vs file-scoped (`alwaysApply`,
  `globs`).
- Adding or fixing a thin `skills/<name>/SKILL.md` that uses
  `Apply @<rule-stem>`.
- Reviewing a change set for consistent naming between rule filename, `@`
  reference, and frontmatter `name`.

**When not to use**

- Implementation work (features, bugs) where you are not editing rule or skill
  metadata and body for agent guidance.
- Typo-only fixes in prose with no scope or pairing implications (skip the
  full workflow).

## Core Process

When creating or updating a rule, follow these steps in order.

1. **Apply the `gsm-create-skill` quality bar by reference**
   - Treat the rule body like a skill: concrete steps over vague advice,
     **Overview** / **When to Use** where helpful, verification when the rule
     encodes a process, and a **Common Rationalizations** table for skip-prone
     steps.
   - Do **not** paste the full SKILL.md anatomy spec here; use **`gsm-create-skill`**
     as the source of truth for that checklist.

2. **Gather scope and activation**
   - **Purpose:** What must the agent reliably do or avoid when this rule
     applies?
   - **Activation:** Should it apply to **every** session, only when certain
     files are in play, or only when invoked via a thin skill? If unknown, ask
     once: always-on vs file patterns vs manual/`Apply @` only.
   - For file-scoped rules outside this repo’s layout, collect **globs** (e.g.
     `**/*.ts`). For universal standards, prefer `alwaysApply: true` (and
     keep the rule focused).

3. **Choose path and filename**
   - **This repository:** `rules/<topic>-rule.mdc`, using existing `ao-*-rule`
     and `gsm-*-rule` prefixes to match sibling files (e.g.
     `ao-incremental-implementation-rule.mdc`).
   - **Other Cursor projects:** typically `.cursor/rules/<name>.mdc`.
   - The **`@` reference** in `Apply @…` uses the rule filename **stem**
     (no `.mdc`). Example: file `rules/ao-foo-rule.mdc` is invoked as
     `Apply @ao-foo-rule`.

4. **Author YAML frontmatter**
   - Include a clear **`description`** (discovery / rule picker); align with
     how agents should decide the rule applies.
   - Set **`alwaysApply`** and/or **`globs`** according to step 2. Omit `globs`
     when not file-scoping; omit or set `alwaysApply: false` when the rule is
     not universal.
   - **This repository** also uses a **`name`** key in rule frontmatter (short
     identifier, often without the `ao-` filename prefix). Keep local files
     consistent with neighboring rules rather than inventing a new scheme.

5. **Draft the rule body**
   - Prefer **one primary concern** per rule; split when the file grows hard to
     scan (Cursor’s own guidance: concise, actionable rules).
   - Use headings and examples the same way **`gsm-create-skill`** expects in a
     substantive skill: numbered workflows, explicit do/don’t, and checklists
     where the rule defines exit criteria.

6. **Optionally pair with a thin skill**
   - If the repo pattern applies, add or update `skills/<skill-name>/SKILL.md`
     so it points at the rule:
     - `Apply @<rule-stem>`
   - Keep long guidance in **`rules/…`**; the skill is the pointer, not a
     second source of truth.

7. **Cross-reference instead of duplicating**
   - Point to other **`rules/*.mdc`** paths or **`gsm-create-skill`** by name
     when sharing broader structure guidance; do not copy large blocks from
     other rules.

8. **Run the [Verification](#verification) checklist** before finishing.

## Reference: Rule file (.mdc)

### Layout

**This repository (cursor-global):**

```
rules/
  <prefix>-<topic>-rule.mdc
```

**Typical Cursor project:**

```
.cursor/rules/
  <descriptive-name>.mdc
```

### Frontmatter fields

| Field | Role |
|-------|------|
| `description` | What the rule does; used for discovery and rule UI. |
| `name` | Short identifier (convention in this repo’s `rules/*.mdc`). |
| `alwaysApply` | If `true`, rule applies in every session (use sparingly, keep rule small). |
| `globs` | File pattern when the rule should attach to matching paths (omit if not used). |

Rules are Markdown bodies after the frontmatter; file extension is **`.mdc`**.

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "Rules are just notes; I’ll skip Overview / When to Use." | **`gsm-create-skill`** still applies: vague rules get ignored; scope and triggers need to be explicit. |
| "I’ll set `alwaysApply: true` so I don’t need globs." | Always-on rules burn context; use only for truly universal, short guidance. |
| "The skill can hold the long version; the rule can be empty." | This repo’s pattern is the opposite: **canonical** text in `rules/`, thin skill with `Apply @`. |
| "`Apply @my-rule` is close enough to the filename." | The `@` stem must match the **filename without `.mdc`** or references break. |
| "One 400-line rule file is easier than many." | Harder to apply and review; split by concern and cross-link. |
| "I’ll duplicate `gsm-create-skill` here so the agent sees it once." | Duplication drifts; reference **`gsm-create-skill`** and keep this file rule-specific. |

## Red Flags

- Rule file missing **`description`** or with ambiguous scope (no indication
  of always-on vs file vs invoke-only).
- `Apply @` in a skill does not match any `rules/<stem>.mdc` filename.
- Frontmatter `name` and filename prefix conventions disagree with sibling
  rules without reason.
- Very long always-applied rule that mixes unrelated topics (context cost,
  conflicting guidance).
- Second copy of the same guidance in both `rules/` and `SKILL.md` without a
  clear single source of truth.

## Verification

After creating or changing a rule with this document, confirm:

- [ ] Rule path matches project convention (`rules/…` here or
  `.cursor/rules/…` elsewhere). **Evidence:** path from `ls` or file tree.
- [ ] Frontmatter includes **`description`** and correct **`alwaysApply` /
  `globs`** for the intended activation; **`name`** present if that matches
  sibling rules in this repo. **Evidence:** read top of `.mdc`.
- [ ] If a thin skill points at the rule, `Apply @<stem>` matches the rule
  filename stem. **Evidence:** grep `Apply @` and compare to `rules/*.mdc`
  names.
- [ ] Body follows **`gsm-create-skill`** discipline for substantive
  workflows (concrete steps, rationalizations where agents skip, verification
  when the rule defines a process). **Evidence:** section scan.
- [ ] No large duplicate of **`gsm-create-skill`** text; rule-specific only.
  **Evidence:** diff or read-through.
