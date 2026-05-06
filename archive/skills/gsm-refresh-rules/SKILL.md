---
name: gsm-refresh-rules
description: >-
  Reloads Cursor rules from disk for the current session so the agent reapplies
  constraints that may have faded from context. Use when the user says
  gsm-refresh-rules, /gsm-refresh-rules, refresh rules, relearn rules, or asks
  the agent to re-read applicable rules for this session.
user_invocable: true
---

# GSM: refresh rules

## Goal

Re-read rule files **from disk** (via the Read tool) so workflow constraints,
format requirements, and project conventions apply fresh for the rest of the
session.

## Steps

1. **Infer scope** from the conversation and task: migrations, docs/prose,
   Ruby/Rails changes, tests/spec structure, Rails binstubs/Docker, planning
   artifacts, commits, etc.

2. **Scenario table** — If `~/.cursor/rules/scenario-rule-routing.mdc` exists,
   read it. For every scenario row that matches the current work, read the
   **union** of paths in its Read list (dedupe). Skip paths that are missing.

3. **Globals often worth refreshing** when the task could touch them (or when
   the user wants a broad pass):
   - `~/.cursor/rules/git-commit-message-format.mdc`
   - `~/.cursor/rules/git-no-implicit-commits.mdc`
   - `~/.cursor/rules/plan-artifact-filenames.mdc`
   - `~/.cursor/rules/planning-missing-spec-path.mdc`
   - `~/.cursor/rules/documentation-scope.mdc`
   - `~/.cursor/rules/tdd.mdc`

4. **Workspace rules** — For repo-specific guidance, read applicable files under
   `{workspace}/.cursor/rules/*.mdc` (e.g. `rails.mdc`, `performance.mdc`). If
   the user asks to refresh **all** workspace rules or scope is unclear, read
   each `*.mdc` in that folder (reasonable count only; if huge, prioritize
   filenames that match the task).

5. **Optional** — If `CLAUDE.md` or `AGENTS.md` at the workspace root govern
   this project and the task is substantive, re-read those too.

6. **Reply** — Briefly confirm which rule files were re-read (basenames or
   paths). Do **not** paste full rule bodies unless the user asks.

## Notes

- This skill does not replace the system prompt rules block; it **reloads** the
  same sources so details are vivid again.
- Prefer **reading** over summarizing from memory whenever the user invokes this.
