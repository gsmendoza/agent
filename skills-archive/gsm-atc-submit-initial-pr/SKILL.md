---
name: gsm-atc-submit-initial-pr
description: Submit a drafted initial pull request to GitHub.
user_invocable: true
---

# GSM > ATC > Submit Initial PR

## Description

- Submit a drafted initial pull request to GitHub.

## Workflow

### 1. Preflight

- Proceed with PR submission only when all of the following are true. Otherwise, inform the user and ask for instructions:
  - The branch is up to date with the remote branch.
    - Why: GitHub pull requests must reflect commits pushed to the remote repository.

  - A PR draft is available in conversation context or from a file link previously created by `/gsm-save`.
    - Why: The PR description should be drafted and reviewed before submitting.

### 2. Prepare PR content

- If reading from a draft file, load the draft contents.
- Extract the PR title from the top-level heading (`# <title>`).
- Use the remaining content below the title heading as the PR body.
- Write the PR body to a temporary scratch file (e.g. `<conversation-id>/scratch/pr_body.md`).

### 3. Create the PR

- Use the GitHub CLI to create a draft pull request:
  ```bash
  gh pr create \
    --draft \
    --base <parent-branch> \
    --title "<extracted-title>" \
    --body-file "/path/to/scratch/pr_body.md" \
    --assignee "gsmendoza-narra-labs" \
    --label "CI-Ready"
  ```

- Set `--base` to the parent branch.
  - Parent branch: the branch this one was cut from (e.g. an upstream feature branch in a stack, not the repo default branch).
  - Why: Scopes the PR to commits on this branch only, not work already covered on the parent.

- Provide the link to the created pull request to the user.
