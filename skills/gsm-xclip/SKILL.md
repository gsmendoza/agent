---
name: gsm-xclip
description: >-
  GSM: xclip — copy the last substantive agent response to the clipboard using
  xclip -selection clipboard.
disable-model-invocation: true
---

# GSM: xclip

Copy the last agent response to the clipboard using `xclip -selection clipboard`.

## Instructions

1. Identify the last substantive agent response in the conversation (skip short replies like confirmations or mode-switching guidance).
2. Write the full content of that response to a temporary file (e.g. `/tmp/cursor-xclip.md`).
3. Run `xclip -selection clipboard < /tmp/cursor-xclip.md` to copy it.
4. Delete the temporary file.
5. Confirm to the user that the content has been copied.
