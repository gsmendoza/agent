---
name: gsm-build-best-practice-idor-prevention
description: Scope ActiveRecord associations to prevent IDOR and metadata disclosure in multi-tenant environments. Invoke when defining ActiveRecord model associations on custom query result objects or DTOs.
user_invocable: true
---

# GSM > Build > Best Practice > IDOR Prevention

## Goal

- Ensure that model associations on custom query result objects or DTOs (e.g., inheriting from `AbstractQueryResult`) do not leak names or metadata belonging to other accounts when queried by arbitrary IDs.

## Guidelines

- Understand the vulnerability:
  - Even if a query filters database rows by `account_id`, declaring a plain association (such as `belongs_to :lead_source`) resolves globally by ID in the view (e.g., `status.lead_source.name`). An attacker can pass another account's `lead_source_id` to read their vendor name.
- Apply the remedy:
  - Select the tenant identifier (`account_id`) in the query's SQL statement to populate it on the result object.
  - Scope the `belongs_to` association using an instance-scoped block:
    ```ruby
    belongs_to :lead_source, ->(status) { where(account_id: status.account_id) }, class_name: "LeadSource"
    ```
  - Ensure validations or rendering code handles `lead_source` returning `nil` gracefully, without throwing exceptions or adding warnings.
