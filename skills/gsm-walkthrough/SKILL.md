---
name: gsm-walkthrough
description: Conduct an interactive, bite-sized walkthrough of existing code, workflows, or architectures through progressive Q&A.
user_invocable: true
---

# GSM > Walkthrough

## Description

- Conduct an interactive, bite-sized walkthrough of existing code, workflows, or architectures through progressive Q&A.

## Input

- The feature, file, PR, or architecture to walk through.
- If omitted in the prompt, infer from recent context or ask the user what flow they would like to explore.

## Guidelines

- Do not make file, code, or workspace modifications.
  - Why: This is purely an explanatory and architectural exploration skill.

- Keep explanations bite-sized and modular.
  - Why: Dumping an entire system trace at once overwhelms the conversation context and hinders comprehension.

- Always provide clickable GitHub-style file links (`[filename](file:///path/to/file#L1-L10)`) for code references.

## Workflow

### 1. Identify topic and scope

- Determine the target flow or feature from the prompt or conversation context.
- Perform targeted codebase searches (e.g. searching routes, controllers, models, or components) to locate the relevant files.

### 2. Present bird's-eye roadmap

- Provide a high-level summary of the end-to-end flow or architecture.
- Break the system into its primary subsystems or stages (e.g., Entry Point / Controller, Core Domain / Service, Presentation / Stimulus).
- End with a numbered list of logical components the user can choose to deep-dive into.

### 3. Deep-dive on demand

- When the user selects a component or asks a question:
  - Explain its core responsibility.
  - Highlight the primary code paths and data flow with line links.
  - Explain the architectural rationale or design trade-offs behind why it was built that way.
  - Point out any non-obvious nuances or gotchas.

### 4. Prompt for next steps

- Conclude each response with 2–4 natural follow-up options or next logical subsystems to explore.
- Allow the user to ask clarifying questions at any point.
