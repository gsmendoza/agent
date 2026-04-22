---
name: gsm-walkthrough
description: >-
  Full branch walkthrough from updated tests: follow gsm-walkthrough-outline
  structure with navigable Cursor citations, visible Source/Lines for HTML export,
  and App change prose; write markdown to the current working directory. Prefer
  running gsm-walkthrough-outline first when both outline and walkthrough are wanted.
---

# GSM: Walkthrough

Create a walkthrough of the branch by analyzing updated tests. For each assertion or critical interaction, identify the corresponding application change and explain the likely intention.

**Document shape is not fixed here**—it comes from the **outline** ([`gsm-walkthrough-outline`](/home/gsmendoza/.cursor/skills/gsm-walkthrough-outline/SKILL.md)): section order, flow boundaries, where cross-cutting notes sit (usually inside the main flow), **Unrelated changes**, and per-case **Setup** / **Action** (**Request** / **Response**) / **Assert**. This skill adds line-accurate **`Source:` / `Lines:`**, **navigable citation fences**, and **App change** paragraphs citing `app/` code.

## Relationship to gsm-walkthrough-outline

When the user wants **both** artifacts, run **`gsm-walkthrough-outline` first**. That skill owns **discovery rules**, **Meta**, **feature flows** (main flow first), per-case structure, **Unrelated changes**, and grouping principles.

**Using an outline file**

- If the user gives a path to an outline markdown file, use it as the **skeleton**: headings, section order, flow boundaries, narrative focus, and any **Request** / **Response** split under **Action**.
- Otherwise, if the shell cwd contains a file matching plan-artifact naming with slug **`branch-walkthrough-outline`** (e.g. `ATC-2363-branch-walkthrough-outline.md` when the branch supplies `ATC-2363`), treat it as the outline when present.
- Reconcile with current `git diff`; if the branch changed since the outline was written, prefer the diff.

**No outline**

- Before writing the walkthrough, apply the **Output structure** from [`gsm-walkthrough-outline`](/home/gsmendoza/.cursor/skills/gsm-walkthrough-outline/SKILL.md) (same as producing an outline in the same pass): **Meta**, flows with **main flow first**, per-case **Setup** / **Action** / **Assert**, **Unrelated changes**. Do **not** substitute a legacy template (e.g. global “critical” vs “supporting” sections) unless the user explicitly asks for that shape.

**Why read whole files**

- The outline may rely on **`git diff`** alone; this skill needs **exact line numbers** for fences. Read **full** changed test-related files (and harness/support when cited) where citations apply.

## Instructions

1. **Discovery** — Same base branch and diff scope as [`gsm-walkthrough-outline`](/home/gsmendoza/.cursor/skills/gsm-walkthrough-outline/SKILL.md): include factories, `ApplicationSystemTestCase`, `test/support/**`, and tests outside `test/system/` unless the branch truly only touches a subtree (do not drop shared harness that supports the feature).
2. **Repository root** — Resolve once before writing citations (`git rev-parse --show-toplevel`, or normalized absolute `pwd` if cwd is the repo root). Build every **`Source:`** link from this root.
3. **Read files** — Read full changed test and harness files as needed for exact **`Lines:`** ranges and fences.
4. **Test cases** — Walk each new or modified test case the outline calls out (or that the diff implies when there is no outline). **Order** matches the outline; **within** each case, follow the outline’s **Setup** / **Action** / **Assert** steps—and **Action** sub-bullets **Request** then **Response** when the outline uses that split. If the outline groups by flow rather than by test class, keep that grouping; if it lists cases under a class name, mirror that. Use **Output Format** below for citations and step layout, not for imposing top-level document sections.
5. **Non-class test paths** — For changed `test/` paths that are **not** a test class with examples (factories, `test/support/**`, etc.), do **not** invent a parallel `# <TestClassName>` tree unless the outline does. Place harness notes where the outline puts them (e.g. **main flow**, **Unrelated changes**). With no outline, follow the outline skill’s placement (fold into the relevant flow or **Unrelated changes**).
6. **Application symbols** — When naming classes, modules, or methods, locate definitions under `app/` (search/read as needed) and include navigable citations (**Application code references**).

## Deliverable

When the walkthrough is complete, **persist the full markdown document to disk** in the **shell current working directory** (`pwd`—typically the repository root). Use a file write (for example the **Write** tool) with a **relative path** `./<basename>.md`.

- After saving, briefly confirm the path (relative or absolute) in your reply.
- **Filename:** follow @rules/plan-artifact-filenames.mdc. Use descriptive slug **`branch-walkthrough`** for the full document (e.g. `ATC-2363-branch-walkthrough.md` when the branch supplies `ATC-2363`). The **outline** sibling uses slug **`branch-walkthrough-outline`** so both files can live in the same directory.

**Source:** lines use **absolute** paths as markdown link text and `file://` URLs so readers can **right-click → Copy link** and paste into an editor Open File dialog. **Navigable citation fences** stay **repo-relative** paths as under **Output Format**; the saved file usually lives at the repo root when `pwd` is the repo.

## Output Format

### Document structure (outline-driven)

- **Mirror the outline’s headings and order.** Promote or demote markdown heading levels only as needed so the saved file has a sensible hierarchy (e.g. one top-level `#` document title is optional; avoid skipping levels).
- Expand each outline bullet into prose plus **Visible citations**, fences, and **App change** paragraphs as needed. Do **not** insert extra top-level buckets (such as “Critical infrastructure” / “Supporting infrastructure”) unless they appear in the outline or the user asked for them.
- When the outline lists **cross-cutting** points or **multiple files** for one flow, expand them using **per-citation** prose: **immediately after each** app `**Source:**` / fence triplet for the snippet that bullet describes—not one long paragraph before a run of unrelated fences (see **Prose next to citations** below).
- When there is **no** outline file, structure the document like a written-out [`gsm-walkthrough-outline`](/home/gsmendoza/.cursor/skills/gsm-walkthrough-outline/SKILL.md) artifact (Meta → flows → Unrelated), still using the mechanical rules below for each test case.

### Per-step layout (within each test case)

- Break each case into labeled steps: **`#### Setup:`**, **`#### Action:`**, and **`#### Assert:`** (or the labels the outline uses). If the outline splits **Action** into **Request** and **Response**, use **`#### Action — Request:`** and **`#### Action — Response:`** (or equivalent clear subheadings).
- For **test** code blocks, use **Visible citations** (`**Source:**`, `**Lines:**`) immediately before the fence, then the **` ```startLine:endLine:filepath `** navigable fence with the exact lines from the test file.
- When a step has a corresponding application change, add an **App change:** paragraph below the explanation, with **Visible citations** and **navigable citations** for the application symbols you name.
- Separate every step with a horizontal rule (`---`).

### Application code references

Whenever you refer to **application** code (models, services, controllers, queries, jobs, concerns, etc.), make it easy to open in Cursor **and** preserve path and line range when the document is converted to HTML or viewed in renderers that strip custom fence metadata:

**Visible citations (HTML and external renders)**

- Immediately **before** every application code block, add two plain body lines (not inside headings):
  - `**Source:**` followed by a **markdown link**: link text is the **full absolute file path** (join repository root + path relative to repo root, POSIX-style); link URL is `file:///absolute/path/to/file` with the same path **percent-encoded** where the URL requires it (e.g. spaces as `%20`). Example: `**Source:** [`/home/you/proj/app/models/foo.rb`](file:///home/you/proj/app/models/foo.rb)` so **Copy link** in a preview yields a pasteable location. Remote HTML hosts (e.g. GitHub) often strip or block `file://`; treat **local preview / copy-link** as the main workflow for these links.
  - `**Lines:** m-n` where `m` and `n` are inclusive line numbers (use an en dash `–` or hyphen `-` consistently).
- If an Open File dialog rejects a `file://` URL, strip the `file://` prefix and paste the plain absolute path (leading `/` on Unix).

**Navigable citations (Cursor)**

- On its own line after **Source:** / **Lines:**, open a fenced block using the **` ```startLine:endLine:filepath `** form (path **relative to the repo root**, e.g. `app/services/foo.rb`). Include a minimal snippet (e.g. the `class` / `module` line, or the `def` line and signature).
- Apply at the **first substantive mention** of each app class or module within the current walkthrough section (per test case or outline subsection).
- For every **App change:** paragraph that names a specific method (e.g. `FooController#update`, `BarService#call`), include a citation to that method's definition (`def ...`).
- Prose may still name the constant normally; the citation block is what makes it clickable in Cursor. **Do not** put `file://` URLs or absolute host paths inside citation **fences**—keep fences repo-relative only. **`file://` markdown links are allowed on the `**Source:**` line** for copy-link and viewers that support local file URLs.

### Prose next to citations

When several **app** citations appear in sequence in the same section (typical in a **flow intro** or a stretch of cross-cutting code):

- Place **short explanatory prose immediately after each navigable fence**, scoped only to that snippet (a bold one-line label is fine). Do **not** write one paragraph that describes behavior across many files and then stack fences—the pairing is lost when scrolling or exporting to HTML.
- You may use **at most one** section-level orienter **before** the first fence in that run when it applies equally to **all** following blocks (e.g. “No migrations on this surface”) and **does not** duplicate the per-fence text.
- If [`gsm-walkthrough-outline`](/home/gsmendoza/.cursor/skills/gsm-walkthrough-outline/SKILL.md) lists cross-cutting bullets, **split** them across the matching citations when expanding; do not paste the full list verbatim above only the first fence.

**Convention:** **`Source:`** uses full absolute paths as link text and `file://` URLs; **navigable fences** use paths relative to the repository root; **Lines** ranges are inclusive.

## Example

The fragment below shows **citations and Setup / Action / Assert** only. **Headings** (`# TerminationsTest`, etc.) illustrate one possible outline shape (grouping by test class); if the outline groups by **flow**, use flow headings instead and keep the same fence and **App change** rules.

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
