---
name: gsm-process-receipts-folder
description: Scan receipt images in a folder, extract metadata into a review CSV, then rename and file images after user approval. Use when processing receipts, purchase records, invoices, warranties, or when the user provides a folder of receipt images to catalog.
---

# GSM > Process Receipts Folder

## Overview

Two-phase workflow: (1) scan images and produce a review CSV, (2) after user approval, rename/move images and archive the CSV.

Base directory: `purchases-receipts-invoices-warranties/` (workspace root).

## Phase 1: Scan and create CSV

**Input:** User provides a folder containing receipt images.

1. Scan every image in the folder.
2. Extract from each receipt:
   - **Date** — transaction date (`YYYY-MM-DD`)
   - **Payee** — legal/registered payee name (as printed on receipt)
   - **Store** — short display name for the store
   - **Amount** — numeric total (preserve decimals in CSV)
   - **Page** — page number for multi-page receipts; leave empty for single-page

   **Date inference:** Receipts in a batch are usually close together in time. When a date is faded, ambiguous, or misread (e.g. `2023` vs `2026`), compare against other receipts in the same folder and prefer a date consistent with the cluster. Flag uncertain dates for user review rather than filing under a distant year.
3. Create a CSV named `YYYY-MM-DD.csv` using today's date.
4. Write these columns:

| Column | Description |
|--------|-------------|
| Path | Current path of the image relative to workspace |
| Date | Transaction date |
| Payee | Legal payee name |
| Store | Short store name |
| Amount | Receipt total |
| Page | Page number, or empty |

**Example:** See [0-processed/2026-06-14.csv](../../../0-processed/2026-06-14.csv).

5. Save the CSV in the user-provided folder (not yet moved to `0-processed/`).
6. Tell the user to review and update the CSV before proceeding.

**Do not rename or move images until the user explicitly approves the CSV.**

## Phase 2: Approve and file

**Trigger:** User approves the CSV.

For each row:

1. **Compute destination path** using parameterized formatting:

   ```
   YYYY/MM/YYYY-MM-DD-<store>-<amount>[-<page>].<extension>
   ```

   - `YYYY` and `MM` — from the row's **Date** column
   - `<store>` — parameterize the **Store** value (lowercase, spaces → hyphens, strip/replace unsafe chars, collapse repeated hyphens)
   - `<amount>` — **Amount** with `.` replaced by `-` (e.g. `1680.23` → `1680-23`, `543.7` → `543-7`)
   - `[-<page>]` — include only when **Page** is non-empty (e.g. `-1`, `-2`)
   - `<extension>` — preserve original file extension

2. **Rename and move** the image from **Path** to the destination.
3. **Update** the paths in the CSV.
4. **Move the CSV** to `0-processed/`.

### Filename examples

| Store | Amount | Page | Result |
|-------|--------|------|--------|
| Baguio Water District | 543.7 | — | `2026/06/2026-06-07-baguio-water-district-543-7.jpg` |
| Beneco | 1680.23 | 1 | `2026/06/2026-06-14-beneco-1680-23-1.jpg` |
| SM | 3495.5 | — | `2026/06/2026-06-05-sm-3495-5.jpg` |

## Parameterize helper

Use Rails-style parameterize for store names. In Ruby:

```ruby
store.parameterize  # "Baguio Water District" → "baguio-water-district"
```

Without Ruby, apply the same rules manually: lowercase, replace spaces with hyphens, remove unsafe characters, collapse repeated hyphens.

## Edge cases

- **Multi-page receipts** — same Date, Payee, Store, and Amount; different Page values; each page gets its own file with `-<page>` suffix.
- **Duplicate filenames** — check before moving; ask the user if a destination already exists.
- **Missing or uncertain fields** — leave blank in CSV and flag for user review in Phase 1; do not guess on approval.
- **Ambiguous dates** — receipts in one folder typically share a nearby date range; use sibling receipts as context when OCR yields an outlier year or month.
- **Non-image files** — skip; only process image files in the folder.

## Task progress

```
Phase 1:
- [ ] Scan images in provided folder
- [ ] Extract Date, Payee, Store, Amount, Page
- [ ] Write YYYY-MM-DD.csv
- [ ] User reviews CSV

Phase 2 (after approval):
- [ ] Rename and move each image to YYYY/MM/...
- [ ] Update Path values in CSV
- [ ] Move CSV to 0-processed/
```
