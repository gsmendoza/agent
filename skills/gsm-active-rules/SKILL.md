---
name: gsm-active-rules
description: >-
  Answers which Cursor rules likely apply to the current session: project
  .cursor/rules frontmatter, global user rules when readable, @-mentions, and
  caveats about Cursor injection. Use when the user asks which rules are
  active, wants rule transparency, @-mentions gsm-active-rules, or pastes
  “Which Cursor rules are you following for this session?”
---

# GSM: Active Cursor rules

The user wants clarity on **which Cursor rules apply in this session**. Treat the core question as:

> Which Cursor rules are you following for this session?

## Instructions

1. **Lead with limits**  
   The model does not receive a guaranteed machine-readable “rules manifest” from Cursor. Summarize **what you can infer** from the workspace, conversation, and any files you read—do not claim a definitive internal injection list unless Cursor exposed it in the thread.

2. **Project rules**  
   If the workspace has `.cursor/rules/`, list each `*.mdc` file (basename is enough unless the user wants detail). For each, read the YAML frontmatter and report:
   - `description` (short)
   - `alwaysApply` (true / false / absent)
   - `globs` (if present)

3. **Legacy project file**  
   If `.cursorrules` exists at the repo root, mention it as an additional project-level rules source.

4. **Global (user) rules**  
   When permitted and paths exist, summarize rules under `~/.cursor/rules/` the same way (frontmatter). If you cannot read that directory, say so.

5. **Explicit attachments**  
   Note any rules or rule files the user **@-mentioned** or manually attached in this chat, and any **skills** attached (name + path if visible).

6. **Likely relevance**  
   Briefly separate:
   - **Always-on** (`alwaysApply: true`)
   - **Path-scoped** (`globs`, `alwaysApply: false`)
   - **Conversation-scoped** (manual @, attached skill)

7. **Optional follow-up**  
   If the repo has no `.cursor/rules/` or nothing is inferable, say that and suggest checking **Cursor Settings → Rules** on the user’s machine.

Keep the answer scannable (bullets or small tables). No need to paste full rule bodies unless the user asks.
