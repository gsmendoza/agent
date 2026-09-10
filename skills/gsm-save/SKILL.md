---
name: gsm-save
description: Invoke when saving the agent's response
user_invocable: true
---

# GSM > Save

## Input

- Default - agent's last substantial response.

## Output

- Response saved as a file.
  - Defaults
    - Path (from highest priority):
      - The `GSM_TICKETS_PATH` environment variable
      - `~/`

    - Format - markdown

    - File name
      - Format: `{slug}-{timestamp}.md`
        - Parts
          - slug
            - Based on summary of content

            - Follow Rails parameterize: lowercase, spaces → hyphens, strip/replace unsafe chars, collapse repeated hyphens, trim leading/trailing hyphens

          - timestamp
            - YYYYMMDD-HHMM
            - Set to local time.

        - length - less than 256 characters

        - Example
          - donald-e-knuth-20260512-1430.md

- Include AI attribution at the end of the file.

- Provide the user a link to the file path once file is saved.
  - Purpose: allows user to copy the path from the agent CLI.

## Exception handling

- When encountering exceptions and edge cases, check with the user.
  - Examples
    - It's not clear what response to save.
    - Output directory not writeable.
