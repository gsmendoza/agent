---
name: gsm-review-code-active-record
description: Invoke when reviewing ActiveRecord code
user_invocable: true
---

# GSM > Review > Code > Active Record

## Guidelines

### Security

- Scope ActiveRecord associations on DTOs and query result objects to the tenant
  - When defining ActiveRecord associations (such as `belongs_to`) on custom query result objects or DTOs in a multi-tenant environment, select the tenant identifier (e.g., `account_id`) in the query and use an instance-scoped block (e.g., `belongs_to :lead_source, ->(obj) { where(account_id: obj.account_id) }`), so that data from other accounts does not leak via arbitrary IDs (IDOR/metadata disclosure).

### Performance

- Use EXISTS subqueries for database presence checks
  - When checking for record existence in database queries, use SQL `EXISTS` subqueries instead of `COUNT(*) > 0`, so that the database can short-circuit and return immediately upon finding the first match.
