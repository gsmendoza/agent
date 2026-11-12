---
name: gsm-follow-paragraph-style-layout-guidelines
description: Apply paragraph-style layout guidelines to regular text and code. Invoke when formatting or structuring text and code layouts.
user_invocable: true
---

# GSM > Follow Paragraph-Style Layout Guidelines

## Description

- Apply paragraph-style layout guidelines to regular text and code. Invoke when formatting or structuring text and code layouts.

## Scope

- Applies to regular text (e.g., Markdown) and code (e.g., YAML, Ruby, JavaScript).

## General rules

- Use strictly one blank line when separating lines or blocks.
  - Never use consecutive blank lines.

## Definitions

- Multiline block
  - A block that has child lines, spanning from its opening line to its last child or explicit closing delimiter (e.g., `end`, `}`, `]`).

- Closing delimiter
  - An explicit delimiter that closes a multiline block (e.g., `end`, `}`, `]`).
  - Considered part of the multiline block it closes.
  - Never add a blank line immediately before a closing delimiter, and do not separate adjacent closing delimiters.

- Comments, tags, and decorators
  - Inline comments, annotations, decorators, and metadata tags (e.g., `# comment`, `@decorator`, `:focus`).
  - Bind directly to the line or block they target. Do not separate them from the target with a blank line.

- Similar or connected lines
  - Single lines sharing a common context or grouped operation (e.g., consecutive variable assignments, `require`/`import` statements, attribute declarations, or tight sequential expressions).

## Decision tree

- Is the line the first line of a file?
  - If yes, don't add a blank line before it.

  - If no:
    - Is the line the first child of a multiline block?
      - If yes:
        - Is the parent block a section heading (e.g., Markdown `# Heading`)?
          - If yes, separate it from the heading with a blank line.
          - If no, don't add a blank line before it.

      - If no:
        - Is the line the start of a multiline block?
          - If yes, add a blank line before it.

          - If no (it's a single line):
            - Is the line preceded by a multiline block?
              - If yes, separate it from the block with a blank line.

              - If no (the preceding line is also a single line):
                - Is the line similar or connected to the previous line?
                  - If yes, don't separate the two lines.
                  - If no, separate the two lines.

## Examples

### Markdown

```markdown
# Section Heading

- First bullet (single line)

- Second bullet (multiline block)
  - First child under block (no blank line before it)
  - Second child under block

- Third bullet (preceded by multiline block, separated by blank line)
```

### Ruby

```ruby
# Service to process orders
class ProcessOrder
  attr_reader :order, :user

  def initialize(order:, user:)
    @order = order
    @user = user
  end

  def call
    return unless order.pending?

    calculate_totals
    send_notifications
  end
end
```

### JavaScript

```javascript
import { validateUser } from "./auth";
import { formatCurrency } from "./utils";

function renderSummary(user, order) {
  const name = user.name;
  const total = formatCurrency(order.total);

  if (order.items.length === 0) {
    return null;
  }

  return {
    customer: name,
    amount: total,
  };
}
```

### YAML

```yaml
version: "1.0"
service: web

environment:
  NODE_ENV: production
  PORT: 3000

dependencies:
  - redis
  - postgres
```
