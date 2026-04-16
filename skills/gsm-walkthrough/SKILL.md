---
name: gsm-walkthrough
description: >-
  Create a branch walkthrough from updated tests: map assertions and interactions
  to application changes, with navigable Cursor citations and visible Source/Lines
  for HTML export.
---

# GSM: Walkthrough

Create a walkthrough of the branch by analyzing all updated tests. For each assertion or critical interaction, identify the corresponding change in the application and explain the possible intention behind the change.

## Instructions

1. Find the base branch (e.g. `main` or `master`).
2. Run `git diff <base_branch> -- test/` to list changed files under the test directory (paths relative to the repo root). Default to the whole `test/` tree so factories, `ApplicationSystemTestCase`, and tests outside `test/system/` are included. You may narrow the path when the branch truly only touches a subtree, but **do not** omit shared harness or factory files that support the feature.
3. Read the full changed test-related files so you can cite exact line ranges. **Do not** put file paths or line ranges in **headings** (`#`, `##`, `####`); use citations in the body as specified under **Visible citations**, **Application code references**, and **Test Walkthroughs**.
4. For each changed file that defines a **test class with examples** (typically `class SomethingTest` in `test/**/*_test.rb`), walk through each new or modified test case.
5. For changed files under `test/` that are **not** a test class with examples (e.g. `ApplicationSystemTestCase`, factories under `test/factories/`, `test/support/**`), do **not** add a `# <TestClassName>` section. Summarize them under **Supporting Infrastructure Changes** (optionally grouped as "Test harness / factories") using the same citation rules.
6. Within each test case, break down the code into logical steps: setup, actions, and assertions.
7. For each step, identify the corresponding application change in the diff and explain the intention.
8. When naming application classes, modules, or methods, locate their definitions under `app/` (search/read as needed) and include a navigable citation (see **Application code references** below).

## Output Format

Use the following structure:

### Critical Infrastructure Changes (at the start)

Before the test walkthroughs, add a **Critical Infrastructure Changes** section listing major cross-cutting changes that are necessary for the feature but don't map directly to a single test assertion. This includes:

- Database migrations (new columns, indexes, table changes)
- Dependency updates (new gems, version bumps)
- Configuration changes (feature flags, environment settings)
- Major model relationship changes (new associations, foreign keys)

For each item, briefly explain what changed and why it's needed. When you name a concrete class, module, or migration-backed model, add a **navigable citation** to its definition (same rules as **Application code references**), including **Visible citations** before each code block.

### Application code references

Whenever you refer to **application** code (models, services, controllers, queries, jobs, concerns, etc.), make it easy to open in Cursor **and** preserve path and line range when the document is converted to HTML or viewed in renderers that strip custom fence metadata:

**Visible citations (HTML and external renders)**

- Immediately **before** every application code block, add two plain body lines (not inside headings):
  - `**Source:** \`relative/path/from/repo/root\`` (backticks around the path)
  - `**Lines:** m-n` where `m` and `n` are inclusive line numbers (use an en dash `–` or hyphen `-` consistently).

**Navigable citations (Cursor)**

- On its own line after **Source:** / **Lines:**, open a fenced block using the **` ```startLine:endLine:filepath `** form (path relative to the repo root, e.g. `app/services/foo.rb`). Include a minimal snippet (e.g. the `class` / `module` line, or the `def` line and signature).
- Apply at the **first substantive mention** of each app class or module within a walkthrough section (per test case or infrastructure subsection).
- For every **App change:** paragraph that names a specific method (e.g. `FooController#update`, `BarService#call`), include a citation to that method's definition (`def ...`).
- Prose may still name the constant normally; the citation block is what makes it clickable in Cursor. Do not rely on `file://` URLs for this.

### Test Walkthroughs (middle)

- Use **`# <TestClassName>`** as the top-level heading (one section per test class). Do **not** use the test file path in headings.
- Use **`## <test description / name>`** as the second-level heading for each test case. Do **not** include line numbers or file paths in any walkthrough headings.
- Each test case is broken into labeled steps with a code block followed by an explanation. Use `#### Setup:`, `#### Action:`, and `#### Assert:` prefixes to label each step.
- For **test** code blocks, use the same pattern as application code: **Visible citations** (`**Source:**`, `**Lines:**`) immediately before the fence, then the **` ```startLine:endLine:filepath `** navigable fence with the exact lines from the test file.
- When a step has a corresponding application change, add an **App change:** paragraph below the explanation, with **Visible citations** and **navigable citations** for the application symbols you name.
- Separate every step with a horizontal rule (`---`).

### Supporting Infrastructure Changes (at the end)

After all test walkthroughs, add a **Supporting Infrastructure Changes** section listing only noteworthy secondary or optional changes -- things that are nice-to-have, improve consistency, or support edge cases but are not strictly required for the core feature to work (e.g. UUID refresh callbacks, post-merge backfill jobs, test helper refactors, factories, base test case flag toggles). Use the same **Application code references** rules (including **Visible citations**) when naming app code or citing test harness files.

**Convention:** Paths in **Source:** are relative to the repository root; **Lines** ranges are inclusive.

## Example

---

# TerminationsTest

## should not show item when manually linked to a rewritten policy

#### Setup: 3 items, one with an unlinked rewrite

**Source:** `test/system/dashboard_retention/terminations_test.rb`  
**Lines:** 560–562

```560:562:test/system/dashboard_retention/terminations_test.rb
3.times { create_termination_task_item }
retention_task_item = termination_task_group.retention_task_items.last
policy_rewrite = create_policy_rewrite(event: retention_task_item.termination_event)
```

Creates 3 termination task items and a `PolicyRewrite` that is not yet linked to the original terminated policy.

---

#### Assert: all 3 items visible before linking

**Source:** `test/system/dashboard_retention/terminations_test.rb`  
**Lines:** 566–567

```566:567:test/system/dashboard_retention/terminations_test.rb
assert_retention_task_item_row_count(count: 3)
assert_policy_presence(policy_number: retention_task_item.policy_number)
```

With no link established, all 3 items are visible.

---

#### Action: select the terminated policy and save

**Source:** `test/system/dashboard_retention/terminations_test.rb`  
**Lines:** 576–577

```576:577:test/system/dashboard_retention/terminations_test.rb
click_mapping_dropdown(retention_task_item.policy_number, "policy_sale_original_policy_type_policy_number")
click_on "Save"
```

The user selects the terminated policy from the dropdown and saves.

**App change:** After a successful save, `DashboardQuoteActivityHistoryController#update` calls `assign_original_policy`, which delegates to `AgentTransactionRuns::RewritePolicyLinkService` with `origin: "manual"`.

**Source:** `app/controllers/dashboard_quote_activity_history_controller.rb`  
**Lines:** 57–58

```57:58:app/controllers/dashboard_quote_activity_history_controller.rb
  def update
    original_policy = (params[:source] == "sale") ? PolicySale.includes(:household).find_by(id: params[:id]) : PolicyQuote.find_by(id: params[:id])
```

**Source:** `app/controllers/dashboard_quote_activity_history_controller.rb`  
**Lines:** 92–92

```92:92:app/controllers/dashboard_quote_activity_history_controller.rb
      assign_original_policy(policy)
```

**Source:** `app/services/agent_transaction_runs/rewrite_policy_link_service.rb`  
**Lines:** 1–2

```1:2:app/services/agent_transaction_runs/rewrite_policy_link_service.rb
class AgentTransactionRuns::RewritePolicyLinkService
  extend Dry::Initializer
```

**Source:** `app/services/agent_transaction_runs/rewrite_policy_link_service.rb`  
**Lines:** 16–17

```16:17:app/services/agent_transaction_runs/rewrite_policy_link_service.rb
  def call
    assign_policy_rewrite_attributes
```

---

#### Assert: linked item is now hidden

**Source:** `test/system/dashboard_retention/terminations_test.rb`  
**Lines:** 579–581

```579:581:test/system/dashboard_retention/terminations_test.rb
visit service_retention_path(tab: "termination")
assert_retention_task_item_row_count(count: 2)
assert_no_policy_presence(policy_number: retention_task_item.policy_number)
```

After linking, the item is filtered out (count drops from 3 to 2).

**App change:** `Retentions::RetentionTaskItems::TerminationQuery` JOIN logic on `policy_rewrites` was tightened to also match on `original_policy_type_id`.

**Source:** `app/queries/retentions/retention_task_items/termination_query.rb`  
**Lines:** 1–2

```1:2:app/queries/retentions/retention_task_items/termination_query.rb
class Retentions::RetentionTaskItems::TerminationQuery
  extend Dry::Initializer
```

---

## Final Section

End with **Supporting Infrastructure Changes** listing only noteworthy secondary or optional changes (see Output Format above).
