---
name: gsm-follow-presentation-code-guidelines
description: Invoke when planning, writing, or reviewing views or other presentation code
user_invocable: true
---

# GSM > Follow > Presentation Code Guidelines

## Guidelines

### Design & Architecture

- Store text in translation dictionary files
  - When working with views and other presentation code, prefer text in translation dictionary files over hardcoded strings, so that copy is centralized.

- Use `data-test-id` attributes as test hooks, not styling classes
  - When a test needs to target a specific element that isn't otherwise identifiable by semantic content or role, add a `data-test-id` attribute to the element rather than asserting on a CSS/styling class, so that visual/styling changes don't break test correctness.

