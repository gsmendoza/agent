---
name: gsm-follow-method-documentation-code-guidelines
description: Invoke when planning, writing, or reviewing method documentation
user_invocable: true
---

# GSM > Follow > Method Documentation Code Guidelines

## Goal

- Write method documentation that serves as lightweight public API documentation.

## Guidelines

### Applicability

- Add method documentation only when it fills a genuine gap the method's own name doesn't already close.
  - Treat method documentation as the "long" version of the method's name.

### Writing style

- Base the phrasing on whether the method is a thing (noun) or an action (verb).

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

### Scope

- Limit the method's documentation to its public interface: its signature, params, return values, side effects, and exceptions.
  - Comments concerning the method's internals should be inline.

- Avoid adding documentation that can be inferred from either the method's code or its tests.
  - Why: comments cannot be tested and can go stale/invalid.

### Preference

- Prefer these guidelines over conventions followed by surrounding code.
  - Why: existing comments in the wild are often low-quality or AI-generated and rarely reviewed carefully, so they're unreliable models to follow.


