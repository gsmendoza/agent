---
name: gsm-review-code
description: Invoke when user asks for a code review
user_invocable: true
---

# GSM > Review > Code

## Input

- Git diff to review.
  - Default: Diff of the current branch against its parent branch.

  - The user might specify a different review scope. Examples:
    - Uncommitted changes (unstaged or staged)
    - The last commit

- Model to use for the review.
  - If not specified, ask the user.

## Process

- Perform a general code review, focusing on these areas:
  - Correctness
  - Performance
  - Security
  - Design & Architecture

- See the Guidelines section below for specific rules within these areas.

## Guidelines

### Correctness

- Prefer explicit nil or truthiness checks for non-string values in Ruby
  - When checking non-string values in Ruby, check the truthiness of the value directly or check `value.nil?` (rather than calling `present?` or `blank?`), so that the check is explicit and avoids unexpected boolean behavior (e.g. `false.blank?` returning `true`).

### Performance

- Use EXISTS subqueries for database presence checks
  - When checking for record existence in database queries, use SQL `EXISTS` subqueries instead of `COUNT(*) > 0`, so that the database can short-circuit and return immediately upon finding the first match.

### Security

- Scope ActiveRecord associations on DTOs and query result objects to the tenant
  - When defining ActiveRecord associations (such as `belongs_to`) on custom query result objects or DTOs in a multi-tenant environment, select the tenant identifier (e.g., `account_id`) in the query and use an instance-scoped block (e.g., `belongs_to :lead_source, ->(obj) { where(account_id: obj.account_id) }`), so that data from other accounts does not leak via arbitrary IDs (IDOR/metadata disclosure).

### Design & Architecture

- Separate core/library code from execution contexts
  - When writing core or library logic, keep it independent of execution contexts (e.g., CLI, UI, or process control), so that it can be reused across different runtimes.

- Target specific exception classes when rescuing
  - When handling errors with rescue or catch blocks, target the narrowest exception class possible, so that unrelated or unexpected exceptions are not silently swallowed.

- Enforce fail-fast on critical paths and safety checks
  - When executing critical paths or safety checks, do not swallow exceptions silently (e.g., by returning empty values or nil), so that failures are not mistakenly assumed to be successful.

## Output

- Report the findings.
