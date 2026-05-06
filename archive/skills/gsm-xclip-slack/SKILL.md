---
name: gsm-xclip-slack
description: >-
  GSM: xclip (Slack) — copy the last substantive agent response to the clipboard
  as Slack-compatible markdown (no ATX headers; nested lists use four spaces per
  level), using xclip -selection clipboard.
disable-model-invocation: true
---

# GSM: xclip (Slack)

Copy the last substantive agent response to the clipboard using `xclip -selection clipboard`, after rewriting it into **Slack-friendly markdown** suitable for pasting into a Slack message.

## Instructions

1. Identify the last substantive agent response in the conversation (skip short replies like confirmations or mode-switching guidance).
2. Rewrite that response into Slack-oriented markdown:
   - **No ATX headers:** Do not leave lines starting with `#`. Strip `######` … `#` prefixes from heading lines. Present the title text as a normal line, optionally emphasized with Slack bold: `*Title*` (Slack mrkdwn uses `*…*` for bold and `_…_` for italic).
   - **Nested lists:** Slack expects each nesting level to be indented with **four spaces** before the list marker (`-`, `*`, or `1.`). Convert any other indentation (for example two-space Markdown nesting) so that depth *n* uses *n* × 4 leading spaces before the marker. Keep blank lines between major blocks if that improves readability in Slack.
   - Preserve fenced code blocks (triple backticks), inline code (single backticks), links, block quotes (`>`), and strikethrough (`~…~`) where they remain valid in Slack; fix only what conflicts with the rules above.
3. Write the transformed content to a temporary file (e.g. `/tmp/cursor-xclip-slack.md`).
4. Run `xclip -selection clipboard < /tmp/cursor-xclip-slack.md` to copy it.
5. Delete the temporary file.
6. Confirm to the user that the **Slack-formatted** content has been copied to the clipboard.
