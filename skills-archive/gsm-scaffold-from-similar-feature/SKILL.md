---
name: gsm-scaffold-from-similar-feature
description: >-
  Builds a new feature by cloning a similar existing one as a named scaffold: duplicate
  routes, controllers, views, queries, and tests using the target domain naming while
  delegating to the donor implementation until a follow-up swap. Use when the user asks
  for a scaffold copied from a similar feature, diff-friendly duplication, a Step 1 clone
  before real data, or parallel tabs/pages modeled on an existing one.
---

# gsm: Scaffold from a similar feature

## When to use

- A **new surface** (tab, report, API) should mirror an **existing** one first.
- Goal: **first commit** is a **scaffold** (same behavior as donor), **later** commits swap internals so `git diff` stays readable.
- User mentions **clone**, **duplicate then replace**, or **scaffold like X**.

## Testing workflow

Follow the team’s TDD expectations in **[TDD rules](../../rules/tdd.mdc)** (red → green → refactor, regression tests for fixes, run tests before calling work complete).

## Workflow (scaffold phase)

1. **Identify donor and target**
   - **Donor:** feature to copy (e.g. Staff Members ranking).
   - **Target:** new product name and identifiers (routes, partials, `lead_source_type`, tests).

2. **Map shared vs duplicated**
   - **Shared:** shell UI, filters, parent queries, layout components, i18n keys used by multiple variants, anything already parameterized for N variants.
   - **Duplicate (target-named):** route, controller action, drill-down partial, optional query wrapper class, **tests** mirroring donor behavior through target entry points.

3. **Implement scaffold**
   - Wire **target** route and path helpers to **target** partials.
   - **Target** controller/query calls **donor** implementation until the swap; pass **donor** locals into **target** partial if the partial is a literal clone.
   - **Partial:** copy donor ERB to target file when needed for diffability; keep variable names donor-side if step 1 is “same table” semantics.
   - Respect feature flags / permissions the same way the donor or product requires (`Flipper`, helpers); add tests for **off** and **on** when applicable.

4. **Commit boundary**
   - Prefer **one commit** for scaffold + tests; avoid folding “real target behavior” into the same commit unless the user explicitly asks.

5. **Follow-up**
   - Replace donor calls with target-specific logic; update tests for target semantics; keep route/tab names stable where possible.

## Naming

- Routes, helpers, partials, tests: **target** vocabulary.
- Until swap, internals may still reference **donor** classes; a short comment on the target action is enough.

## Checklist before calling scaffold done

- [ ] Target route + path + visible entry (tab, menu, etc.) + i18n if UI.
- [ ] Drill-down / turbo targets use **target** URLs where applicable.
- [ ] Tests and commands per **[TDD rules](../../rules/tdd.mdc)**.
- [ ] Scaffold is committable separately from the behavior swap.

## Anti-patterns

- Implementing the **target** data model inside the scaffold commit “to save time.”
- **Refactoring donor shared code in place** and breaking other consumers.
- **Skipping** tests because “it is temporary” — scaffold is shipped code.
