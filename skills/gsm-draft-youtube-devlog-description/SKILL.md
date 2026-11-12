---
name: gsm-draft-youtube-devlog-description
description: Draft a YouTube video description for a devlog video and save it with /gsm-save.
user_invocable: true
---

# GSM > Draft YouTube Devlog Description

## Description

- Draft a YouTube video description for a devlog video and save it with `/gsm-save`.

## Input

- A transcript of the video, copied from the video's YouTube page.

## Output

- A YouTube description for the devlog video, saved via `/gsm-save`.
  - Content:
    - Title:
      - The title for the YouTube video.
      - Format: `<YYYY-MM-DD> <title>`

      - YouTube requirements:
        - Keep the length to 100 characters or fewer.

    - Video chapters:
      - Reference: https://support.google.com/youtube/answer/9884579?hl=en

      - Format: `<timestamp> <title>` per line (e.g., `00:00 Intro`).

      - Guidelines:
        - Consider creating a chapter for each commit made during the video.
          - Find the commits in the app repo's git history.
            - Find the app repo path in the devlog project's `AGENTS.md` file.

      - YouTube requirements:
        - Start the first timestamp at `00:00`.
        - Include at least three timestamps in ascending order.
        - Ensure each video chapter is at least 10 seconds long.
