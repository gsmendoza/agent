---
name: gsm-save
description: >-
  Saves the agent's substantive markdown reply to a timestamped file under
  `/tmp`. When gsm-save (`/gsm-save`) runs with user text that asks for new
  work or an answer, complete that substantive reply then save exactly that reply
  to disk. When gsm-save runs with no substantive ask, save the last substantive
  assistant message from the conversation. Use when the user says gsm-save,
  /gsm-save, save to tmp, save last response to /tmp, or save this answer under
  /tmp.
user_invocable: true
---

# GSM: save (`/tmp`)

Persist assistant output under `/tmp` as markdown for reuse outside chat.

## What counts as substantive

Same idea as `gsm-xclip`: skip boilerplate confirmations, terse acks (“Done.”), meta about tools, or mode-only replies. Preserve code blocks, headings, lists, and citations intact.

## Path and name

Write one file:

- **`/tmp/gsm-save-{YYYYMMDD}-{HHMMSS}.md`** where the timestamp reflects **now** (local time unless the session is clearly UTC-focused). Optionally append a hyphen and a short `parameterize`-style slug derived from the first heading or first words of saved content (`gsm-save-20260429-143022-ruby-modules-outline.md`).
- Prefer **`.md`** so fenced code and markdown stay readable.

## Branch A — User included a substantive prompt

Examples: `/gsm-save` on the **same message** as a question (“summarize…”); or “`/gsm-save` then explain…” on one line/block.

1. Produce the **full substantive answer** to that prompt if it is **not already** supplied in **this assistant turn**.
2. **Write** that answer to the file path above (content is **only** the substantive reply, not a copy of the user’s question unless the user asked for Q&A format).
3. Tell the user the **absolute path** in one line.

## Branch B — gsm-save alone or no substantive ask

Examples: “`/gsm-save`”, “gsm-save”, “save last response”, no other task on the invocation.

1. Identify the **prior** substantive assistant message (not the gsm-save acknowledgement you may be composing).
2. If there is none, say so plainly and **do not** create an empty file.
3. Otherwise **Write** that message’s full body to the file path above.
4. Tell the user the **absolute path** in one line.

## Duplicate saves

If Branch B fires immediately after Branch A saved the same reply in **one composite turn**, one file is enough; avoid writing two identical files unless the user asked to save twice.

## Optional shell

If the session already used `date` for something else, `date +%Y%m%d-%H%M%S` is a fine stem for `{YYYYMMDD}-{HHMMSS}`; otherwise infer a suitable timestamp without requiring a shell round-trip.
