---
name: gsm-build-best-practice-nil-over-blank
description: Invoke when writing Ruby code
user_invocable: true
---

# GSM > Build > Best Practice > Nil over blank

## Goal

- Prefer explicit nil or truthiness checks over blank/present checks for non-string values.

## Guidelines

- Use `value.present?` and `value.blank?` when expecting a string and needing to handle blank/empty string scenarios.

- If the value is not a string, check `value` directly or check for nil using `value.nil?`.
