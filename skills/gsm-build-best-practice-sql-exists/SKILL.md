---
name: gsm-build-best-practice-sql-exists
description: Use SQL EXISTS subqueries instead of COUNT for presence checks in database queries. Invoke when writing or optimizing database queries for existence or presence checks.
user_invocable: true
---

# GSM > Build > Best Practice > SQL EXISTS

## Goal

- Optimize existence/presence check queries in PostgreSQL to use short-circuiting subqueries rather than counting records.

## Guidelines

- Avoid the anti-pattern of using `COUNT(*) > 0` or `COUNT(column) > 0` to check for record existence.
  - Why: This forces the database to perform a full scan of all matching rows, which is slow ($O(N)$) for large datasets.
- Use `EXISTS` subqueries instead.
  - Why: It allows the database to short-circuit ($O(1)$) and return immediately upon locating the first match.
  - Example:
    ```sql
    SELECT
      EXISTS (
        SELECT 1 FROM leads
        WHERE leads.account_id = :account_id
          AND leads.lead_source_id = :lead_source_id
          AND leads.received_date >= :start_time
      ) AS has_leads
    ```
