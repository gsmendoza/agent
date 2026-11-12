---
name: gsm-check-video-leaks
description: Check a video and its transcript for leaked personal, private, or secured information.
user_invocable: true
---

# GSM > Check Video for Leaks

## Description

- Check a video and its transcript for leaked personal, private, or secured information.

## Input

- A video file and its transcript.

## Instructions

- Scan the transcript first to identify high-risk timestamps:
  - Opening or closing notes, journals, or inboxes
  - File dialogs or directory browsing
  - Signing in, logging out
  - Moments right before or after pausing the recording
  - Why: The transcript reveals where sensitive windows, dialogs, or credentials are most likely to appear.

- Extract and inspect frames from the video:
  - Sample frames across the entire video to catch unmentioned visual leaks.

  - Sample at a higher frame rate around high-risk timestamps and pause boundaries.
    - Why: Restored editor windows, file chooser breadcrumbs, or auth prompts may appear for only a second before being closed or paused.

  - Inspect full-resolution crops when text in dialogs or background windows is small.
  - Clean up temporary extracted frames after inspection.

## Output

- A summary of findings grouped by category and severity, with exact timestamp ranges (`MM:SS – MM:SS`):
  - Secured information (e.g., passwords, API keys, tokens, `config/master.key`, `.env` files)
  - Personal or private information (e.g., journal entries, personal notes, family details, financial filenames or folder paths)
  - Account or identity information (e.g., email addresses, usernames)
  - High-risk moments confirmed safe (e.g., where the recording was paused before sensitive content appeared)
