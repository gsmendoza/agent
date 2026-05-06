---
name: gsm-create-skill
description: >-
  Documents agent-skill file structure and guides authoring or review of
  SKILL.md files. Use when creating a new skill, substantially editing
  SKILL.md, auditing skill layout and discovery metadata, or contributing
  skills under this repository's skills/ tree.
---

# gsm-create-skill

## Overview

Structured skills steer agents with discoverable metadata, explicit workflows,
and anti-rationalization guardrails. This skill defines that anatomy and
prescribes how to apply it when you author or change a `SKILL.md`.

## When to Use

- Creating a new skill directory and `SKILL.md`.
- Major edits to an existing skill (structure, triggers, verification, or
  workflow steps).
- Reviewing a skill PR for format, discovery description quality, or
  consistency with these rules.

**When not to use**

- Executing domain work (features, bugs, refactors) where the task is not
  shaping a skill file — use the relevant `ao-*` or project skill instead.
- One-line typo fixes that do not change structure or metadata (no need to
  run the full workflow below).

## Core Process

When creating or updating a skill, follow these steps in order.

1. **Choose location and directory name**
   - In **this repository**, skills live under the repository root directory
     `skills/` as `skills/<skill-name>/SKILL.md`.
   - Other projects may use `.cursor/skills/` or `~/.cursor/skills/`; the
     same file rules apply. Use the project’s conventional path.
   - Directory name: `lowercase-hyphen-separated`, must match the `name` in
     frontmatter (see [Naming Conventions](#naming-conventions)).

2. **Add required YAML frontmatter**
   - Include `name` and `description` exactly as specified under
     [Frontmatter (Required)](#frontmatter-required).
   - Confirm `name` equals the directory name.
   - Confirm the description states *what* and *when*, in third person, and
     does **not** embed step-by-step workflow (see **Why this matters** in
     that section).

3. **Draft body sections**
   - Use the [Standard Sections (Recommended Pattern)](#standard-sections-recommended-pattern)
     as a checklist: at least **Overview**, **When to Use**, a main workflow
     section (named for the task, e.g. **Core Process**), **Common
     Rationalizations**, **Red Flags**, and **Verification** for substantive
     skills.
   - Make the main workflow **specific and actionable** (see [Purpose: Core
     Process](#purpose-core-process)).

4. **Add anti-rationalization and quality gates**
   - Add or update the **Common Rationalizations** table for every step
     agents commonly skip (see [this skill’s table](#common-rationalizations)
     and [Purpose: Common Rationalizations](#purpose-common-rationalizations)).
   - Add **Red Flags** observable during review or self-check.
   - Add **Verification** checkboxes; each item must be checkable with
     evidence (command output, file diff, screenshot, etc.).

5. **Split supporting files only when justified**
   - Follow [Supporting Files](#supporting-files): extra files when reference
     material is large, scripts are needed, or checklists are long; keep short
     reference inline (under roughly 50 lines of patterns/principles).

6. **Cross-reference instead of duplicating**
   - Point to other skills by name per [Cross-Skill References](#cross-skill-references).

7. **Run the [Verification](#verification) checklist** on the skill you
   changed before finishing.

## Reference: SKILL.md Format

### Frontmatter (Required)

```yaml
---
name: skill-name-with-hyphens
description: Guides agents through [task/workflow]. Use when [specific trigger conditions].
---
```

**Rules:**

- `name`: Lowercase, hyphen-separated. Must match the directory name.
- `description`: Start with what the skill does in third person, then
  include one or more clear "Use when" trigger conditions. Include both *what*
  and *when*. Maximum 1024 characters.

**Why this matters:** Agents discover skills by reading descriptions. The
description is injected into the system prompt, so it must tell the agent
both what the skill provides and when to activate it. Do not summarize the
workflow — if the description contains process steps, the agent may follow
the summary instead of reading the full skill.

### Standard Sections (Recommended Pattern)

```markdown
# Skill Title

## Overview
One-two sentences explaining what this skill does and why it matters.

## When to Use
- Bullet list of triggering conditions (symptoms, task types)
- When NOT to use (exclusions)

## [Core Process / The Workflow / Steps]
The main workflow, broken into numbered steps or phases.
Include code examples where they help.
Use flowcharts (ASCII) where decision points exist.

## [Specific Techniques / Patterns]
Detailed guidance for specific scenarios.
Code examples, templates, configuration.

## Common Rationalizations
| Rationalization | Reality |
|---|---|
| Excuse agents use to skip steps | Why the excuse is wrong |

## Red Flags
- Behavioral patterns indicating the skill is being violated
- Things to watch for during review

## Verification
After completing the skill's process, confirm:
- [ ] Checklist of exit criteria
- [ ] Evidence requirements
```

## Reference: Section Purposes

### Purpose: Overview

The "elevator pitch" for the skill. Should answer: What does this skill do,
and why should an agent follow it?

### Purpose: When to Use

Helps agents and humans decide if this skill applies to the current task.
Include both positive triggers ("Use when X") and negative exclusions ("NOT
for Y").

### Purpose: Core Process

The heart of the skill. This is the step-by-step workflow the agent follows.
Must be specific and actionable — not vague advice.

**Good:** "Run `npm test` and verify all tests pass"
**Bad:** "Make sure the tests work"

### Purpose: Common Rationalizations

The most distinctive feature of well-crafted skills. These are excuses
agents use to skip important steps, paired with rebuttals. They prevent the
agent from rationalizing its way out of following the process.

Think of every time an agent has said "I'll add tests later" or "This is
simple enough to skip the spec" — those go here with a factual
counter-argument.

### Purpose: Red Flags

Observable signs that the skill is being violated. Useful during code review
and self-monitoring.

### Purpose: Verification

The exit criteria. A checklist the agent uses to confirm the skill's process
is complete. Every checkbox should be verifiable with evidence (test output,
build result, screenshot, etc.).

## Supporting Files

Create supporting files only when:

- Reference material exceeds 100 lines (keep the main SKILL.md focused)
- Code tools or scripts are needed
- Checklists are long enough to justify separate files

Keep patterns and principles inline when under 50 lines.

## Writing Principles

1. **Process over knowledge.** Skills are workflows, not reference docs. Steps, not facts.
2. **Specific over general.** "Run `npm test`" beats "verify the tests".
3. **Evidence over assumption.** Every verification checkbox requires proof.
4. **Anti-rationalization.** Every skip-worthy step needs a counter-argument in the rationalizations table.
5. **Progressive disclosure.** Main SKILL.md is the entry point. Supporting files are loaded only when needed.
6. **Token-conscious.** Every section must justify its inclusion. If removing it wouldn't change agent behavior, remove it.

## Naming Conventions

- Skill directories: `lowercase-hyphen-separated`
- Skill files: `SKILL.md` (always uppercase)
- Supporting files: `lowercase-hyphen-separated.md`
- References: stored in `references/` at the project root, not inside skill directories

## Cross-Skill References

Reference other skills by name:

```markdown
Follow the `test-driven-development` skill for writing tests.
If the build breaks, use the `debugging-and-error-recovery` skill.
```

Don't duplicate content between skills — reference and link instead.

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "The body is enough; I'll skip frontmatter." | Without `name` and `description`, agents cannot discover or load the skill consistently; `name` must match the directory. |
| "I'll put the workflow in the `description` to save tokens." | The description is injected into context; process steps there train agents to skip the full `SKILL.md`. |
| "Rationalizations and Red Flags are optional polish." | They are the main defense against skipped steps; omitting them raises rationalization risk called out in [Writing Principles](#writing-principles). |
| "Verification can say 'make sure it works'." | That is not evidence-backed; each item needs a concrete proof (output path, command, artifact). |
| "I'll split the first draft into five small files." | Progressive disclosure means *main* file stays canonical; only split per [Supporting Files](#supporting-files) thresholds. |
| "This overlaps another skill; I'll copy the section." | Duplication drifts apart; reference the other skill per [Cross-Skill References](#cross-skill-references). |

## Red Flags

- `SKILL.md` without YAML frontmatter or with a `name` that mismatches the
  directory.
- Description missing third-person framing, triggers, or exceeding 1024
  characters; description reads like a mini-runbook of steps.
- No **Verification** section, or checkboxes with no definable evidence.
- Main workflow section is vague ("handle appropriately", "ensure quality")
  instead of commands, file paths, or explicit decisions.
- Large copied blocks from another skill instead of a named cross-reference.
- Extra markdown files in the skill dir without meeting [Supporting
  Files](#supporting-files) criteria.

## Verification

After creating or changing a skill using this document, confirm:

- [ ] Frontmatter includes `name` (matches `skills/<name>/` or project path)
  and `description` (what + when, ≤1024 chars, no workflow steps). **Evidence:**
  read `SKILL.md` header.
- [ ] Body includes **Overview**, **When to Use** (with exclusions where
  helpful), a concrete numbered or phased workflow, **Common
  Rationalizations**, **Red Flags**, and **Verification** for non-trivial
  skills. **Evidence:** section headings present.
- [ ] Each verification item in the target skill names *how* to verify (same
  standard as [Purpose: Verification](#purpose-verification)). **Evidence:**
  review checklist rows.
- [ ] Supporting files follow [Supporting Files](#supporting-files) rules.
  **Evidence:** file list in skill directory.
- [ ] Naming follows [Naming Conventions](#naming-conventions). **Evidence:**
  path and filenames.
