---
name: gsm-follow-method-documentation-guidelines
description: Invoke when planning, writing, or reviewing method documentation
user_invocable: true
---

# GSM > Follow > Method Documentation Guidelines

## Goal

- Write method documentation that serves as lightweight public API documentation.

## Definition

- Method documentation
  - Specifically its header documentation (docstring in Python parlance)

## Guidelines

- Preference for these guidelines over surrounding code
  - When code surrounding the method does not follow these guidelines, still apply these guidelines to the method.
    - Why: existing comments in the wild are often low-quality or AI-generated and rarely reviewed carefully, so they're unreliable models to follow.

- Applicability
  - When the method's own name has genuine gaps it doesn't close, add documentation to the method.
    - Why: We want to treat the method documentation as the "long" version of the method's name.

  - When the thing we want to comment on concerns its internals, or the "how" (and not the "what") of the method, put that comment inline instead of adding it to the method documentation.
    - Why: We want the method documentation to focus only on its public interface, as this discourages the documentation from bloating.

  - When the thing we want to comment on can be inferred from either the method's code or its tests, do NOT add a comment for it.
    - Why: We want to keep comments at a minimum since they cannot be tested and can go stale/invalid.

- Phrasing
  - Base the method documentation on whether the method name represents a thing (noun) or an action (verb).
    - Why: This emphasizes the nature of the method: whether it's a query or a command. Additionally, it keeps the documentation of query methods as concise as possible by discouraging the addition of a "Returns the" phrase at the start of the documentation.

    - Examples:
      ```rb
      # Square root of x
      def sqrt(x)
        # ...
      end

      # Calculates the square root of x
      def calculate_sqrt(x)
        # ...
      end
      ```

- Formatting
  - When writing method documentation, follow YARD Markdown-style formatting.
    - Why: this applies a popular documentation format for Ruby.
