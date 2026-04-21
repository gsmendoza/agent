---
name: gsm-walkthrough
description: >-
  Full branch walkthrough from updated tests: expand gsm-walkthrough-outline (or
  standalone) with navigable Cursor citations, visible Source/Lines for HTML export,
  and App change prose; write markdown to the current working directory. Prefer
  running gsm-walkthrough-outline first when both outline and walkthrough are wanted.
---

# GSM: Walkthrough

Create a walkthrough of the branch by analyzing updated tests. For each assertion or critical interaction, identify the corresponding application change and explain the likely intention.

## Relationship to gsm-walkthrough-outline

When the user wants **both** artifacts, run **`gsm-walkthrough-outline` first**. That skill owns **discovery rules**, **Meta**, **critical vs supporting infrastructure**, **feature flows**, and **principles** (flows vs infrastructure, Action vs Assert, tight coupling to the PR). This skill **adds** line-accurate **`Source:` / `Lines:`** lines, **navigable citation fences**, and deeper **App change** paragraphs citing `app/` code.

**Using an outline file**

- If the user gives a path to an outline markdown file, use it as the **skeleton**: section order, scope note, flow boundaries, narrative focus.
- Otherwise, if the shell cwd contains a file matching plan-artifact naming with slug **`branch-walkthrough-outline`** (e.g. `ATC-2363-branch-walkthrough-outline.md` when the branch supplies `ATC-2363`), treat it as the outline when present.
- Reconcile with current `git diff`; if the branch changed since the outline was written, prefer the diff.

**No outline**

- Follow **Instructions** and **Output structure** in [`gsm-walkthrough-outline`](/home/gsmendoza/.cursor/skills/gsm-walkthrough-outline/SKILL.md) for base branch, test delta, app delta, and grouping. Do not duplicate that skill’s prose here.

**Why read whole files**

- The outline may rely on **`git diff`** alone; this skill needs **exact line numbers** for fences. Read **full** changed test-related files (and harness/support when cited) where citations apply.

## Instructions

1. **Discovery** — Same base branch and diff scope as [`gsm-walkthrough-outline`](/home/gsmendoza/.cursor/skills/gsm-walkthrough-outline/SKILL.md): include factories, `ApplicationSystemTestCase`, `test/support/**`, and tests outside `test/system/` unless the branch truly only touches a subtree (do not drop shared harness that supports the feature).
2. **Repository root** — Resolve once before writing citations (`git rev-parse --show-toplevel`, or normalized absolute `pwd` if cwd is the repo root). Build every **`Source:`** link from this root.
3. **Read files** — Read full changed test and harness files as needed for exact **`Lines:`** ranges and fences.
4. **Test classes** — For each changed file that defines a **test class with examples** (`test/**/*_test.rb`), walk through each new or modified test case using **Setup / Action / Assert** (see **Output Format**). If an outline lists flows or cases, follow that order unless the diff disagrees.
5. **Non-class test paths** — For changed `test/` paths that are **not** a test class with examples (factories, `test/support/**`, etc.), do **not** add a duplicate `# <TestClassName>` section per file; summarize under **Supporting Infrastructure Changes** with the same citation rules.
6. **Application symbols** — When naming classes, modules, or methods, locate definitions under `app/` (search/read as needed) and include navigable citations (**Application code references**).

## Deliverable

When the walkthrough is complete, **persist the full markdown document to disk** in the **shell current working directory** (`pwd`—typically the repository root). Use a file write (for example the **Write** tool) with a **relative path** `./<basename>.md`.

- After saving, briefly confirm the path (relative or absolute) in your reply.
- **Filename:** follow @rules/plan-artifact-filenames.mdc. Use descriptive slug **`branch-walkthrough`** for the full document (e.g. `ATC-2363-branch-walkthrough.md` when the branch supplies `ATC-2363`). The **outline** sibling uses slug **`branch-walkthrough-outline`** so both files can live in the same directory.

**Source:** lines use **absolute** paths as markdown link text and `file://` URLs so readers can **right-click → Copy link** and paste into an editor Open File dialog. **Navigable citation fences** stay **repo-relative** paths as under **Output Format**; the saved file usually lives at the repo root when `pwd` is the repo.

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
  - `**Source:**` followed by a **markdown link**: link text is the **full absolute file path** (join repository root + path relative to repo root, POSIX-style); link URL is `file:///absolute/path/to/file` with the same path **percent-encoded** where the URL requires it (e.g. spaces as `%20`). Example: `**Source:** [`/home/you/proj/app/models/foo.rb`](file:///home/you/proj/app/models/foo.rb)` so **Copy link** in a preview yields a pasteable location. Remote HTML hosts (e.g. GitHub) often strip or block `file://`; treat **local preview / copy-link** as the main workflow for these links.
  - `**Lines:** m-n` where `m` and `n` are inclusive line numbers (use an en dash `–` or hyphen `-` consistently).
- If an Open File dialog rejects a `file://` URL, strip the `file://` prefix and paste the plain absolute path (leading `/` on Unix).

**Navigable citations (Cursor)**

- On its own line after **Source:** / **Lines:**, open a fenced block using the **` ```startLine:endLine:filepath `** form (path **relative to the repo root**, e.g. `app/services/foo.rb`). Include a minimal snippet (e.g. the `class` / `module` line, or the `def` line and signature).
- Apply at the **first substantive mention** of each app class or module within a walkthrough section (per test case or infrastructure subsection).
- For every **App change:** paragraph that names a specific method (e.g. `FooController#update`, `BarService#call`), include a citation to that method's definition (`def ...`).
- Prose may still name the constant normally; the citation block is what makes it clickable in Cursor. **Do not** put `file://` URLs or absolute host paths inside citation **fences**—keep fences repo-relative only. **`file://` markdown links are allowed on the `**Source:**` line** for copy-link and viewers that support local file URLs.

### Test Walkthroughs (middle)

- Use **`# <TestClassName>`** as the top-level heading (one section per test class).
- Use **`## <test description / name>`** as the second-level heading for each test case.
- Each test case is broken into labeled steps with a code block followed by an explanation. Use `#### Setup:`, `#### Action:`, and `#### Assert:` prefixes to label each step.
- For **test** code blocks, use the same pattern as application code: **Visible citations** (`**Source:**`, `**Lines:**`) immediately before the fence, then the **` ```startLine:endLine:filepath `** navigable fence with the exact lines from the test file.
- When a step has a corresponding application change, add an **App change:** paragraph below the explanation, with **Visible citations** and **navigable citations** for the application symbols you name.
- Separate every step with a horizontal rule (`---`).

### Supporting Infrastructure Changes (at the end)

After all test walkthroughs, add a **Supporting Infrastructure Changes** section listing only noteworthy secondary or optional changes -- things that are nice-to-have, improve consistency, or support edge cases but are not strictly required for the core feature to work (e.g. UUID refresh callbacks, post-merge backfill jobs, test helper refactors, factories, base test case flag toggles). Use the same **Application code references** rules (including **Visible citations**) when naming app code or citing test harness files.

**Convention:** **`Source:`** uses full absolute paths as link text and `file://` URLs; **navigable fences** use paths relative to the repository root; **Lines** ranges are inclusive.

## Example

(Placeholder repo root `/home/you/repos/example-app`—replace with the real absolute root from `git rev-parse --show-toplevel` when generating a walkthrough.)

---

# TerminationsTest

## should not show item when manually linked to a rewritten policy

#### Setup: 3 items, one with an unlinked rewrite

**Source:** [`/home/you/repos/example-app/test/system/dashboard_retention/terminations_test.rb`](file:///home/you/repos/example-app/test/system/dashboard_retention/terminations_test.rb)  
**Lines:** 560–562

```560:562:test/system/dashboard_retention/terminations_test.rb
3.times { create_termination_task_item }
retention_task_item = termination_task_group.retention_task_items.last
policy_rewrite = create_policy_rewrite(event: retention_task_item.termination_event)
```

Creates 3 termination task items and a `PolicyRewrite` that is not yet linked to the original terminated policy.

---

#### Assert: all 3 items visible before linking

**Source:** [`/home/you/repos/example-app/test/system/dashboard_retention/terminations_test.rb`](file:///home/you/repos/example-app/test/system/dashboard_retention/terminations_test.rb)  
**Lines:** 566–567

```566:567:test/system/dashboard_retention/terminations_test.rb
assert_retention_task_item_row_count(count: 3)
assert_policy_presence(policy_number: retention_task_item.policy_number)
```

With no link established, all 3 items are visible.

---

#### Action: select the terminated policy and save

**Source:** [`/home/you/repos/example-app/test/system/dashboard_retention/terminations_test.rb`](file:///home/you/repos/example-app/test/system/dashboard_retention/terminations_test.rb)  
**Lines:** 576–577

```576:577:test/system/dashboard_retention/terminations_test.rb
click_mapping_dropdown(retention_task_item.policy_number, "policy_sale_original_policy_type_policy_number")
click_on "Save"
```

The user selects the terminated policy from the dropdown and saves.

**App change:** After a successful save, `DashboardQuoteActivityHistoryController#update` calls `assign_original_policy`, which delegates to `AgentTransactionRuns::RewritePolicyLinkService` with `origin: "manual"`.

**Source:** [`/home/you/repos/example-app/app/controllers/dashboard_quote_activity_history_controller.rb`](file:///home/you/repos/example-app/app/controllers/dashboard_quote_activity_history_controller.rb)  
**Lines:** 57–58

```57:58:app/controllers/dashboard_quote_activity_history_controller.rb
  def update
    original_policy = (params[:source] == "sale") ? PolicySale.includes(:household).find_by(id: params[:id]) : PolicyQuote.find_by(id: params[:id])
```

**Source:** [`/home/you/repos/example-app/app/controllers/dashboard_quote_activity_history_controller.rb`](file:///home/you/repos/example-app/app/controllers/dashboard_quote_activity_history_controller.rb)  
**Lines:** 92–92

```92:92:app/controllers/dashboard_quote_activity_history_controller.rb
      assign_original_policy(policy)
```

**Source:** [`/home/you/repos/example-app/app/services/agent_transaction_runs/rewrite_policy_link_service.rb`](file:///home/you/repos/example-app/app/services/agent_transaction_runs/rewrite_policy_link_service.rb)  
**Lines:** 1–2

```1:2:app/services/agent_transaction_runs/rewrite_policy_link_service.rb
class AgentTransactionRuns::RewritePolicyLinkService
  extend Dry::Initializer
```

**Source:** [`/home/you/repos/example-app/app/services/agent_transaction_runs/rewrite_policy_link_service.rb`](file:///home/you/repos/example-app/app/services/agent_transaction_runs/rewrite_policy_link_service.rb)  
**Lines:** 16–17

```16:17:app/services/agent_transaction_runs/rewrite_policy_link_service.rb
  def call
    assign_policy_rewrite_attributes
```

---

#### Assert: linked item is now hidden

**Source:** [`/home/you/repos/example-app/test/system/dashboard_retention/terminations_test.rb`](file:///home/you/repos/example-app/test/system/dashboard_retention/terminations_test.rb)  
**Lines:** 579–581

```579:581:test/system/dashboard_retention/terminations_test.rb
visit service_retention_path(tab: "termination")
assert_retention_task_item_row_count(count: 2)
assert_no_policy_presence(policy_number: retention_task_item.policy_number)
```

After linking, the item is filtered out (count drops from 3 to 2).

**App change:** `Retentions::RetentionTaskItems::TerminationQuery` JOIN logic on `policy_rewrites` was tightened to also match on `original_policy_type_id`.

**Source:** [`/home/you/repos/example-app/app/queries/retentions/retention_task_items/termination_query.rb`](file:///home/you/repos/example-app/app/queries/retentions/retention_task_items/termination_query.rb)  
**Lines:** 1–2

```1:2:app/queries/retentions/retention_task_items/termination_query.rb
class Retentions::RetentionTaskItems::TerminationQuery
  extend Dry::Initializer
```

---

## Final Section

End with **Supporting Infrastructure Changes** listing only noteworthy secondary or optional changes (see Output Format above).
