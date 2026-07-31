---
name: gsm-toolchest-rails-create-initial-pr
description: Invoke when the user requests to create a pull request, draft PR, or push the current branch.
user_invocable: true
---

# GSM > Toolchest Rails > Create Initial PR

## Goal

- Push the local branch and create a draft pull request on GitHub.

## Steps

### Preflight

- Proceed with PR creation only when all of the following are true. Otherwise, inform the user and ask for instructions.
  - The branch is up to date with the remote branch.
  - The user has confirmed they have reviewed the branch.

### Write the PR body

- Write the PR description to a temporary file in the scratch directory (e.g. `/home/gsmendoza/.gemini/antigravity-cli/brain/<conversation-id>/scratch/pr_body.md`).
- Use this template:

```markdown
## Ticket

https://agencytoolchest.atlassian.net/browse/<TICKET_ID>

## Summary

<Summary from the branch's commit messages.>

## Additional changes

<Changes outside the ticket scope or that cross ticket boundaries. Omit this section if none.>

## Demo/Screenshots

TODO

## Seed Data

TODO
```

- Limit the summary to what the PR's commit messages already say; do not add extra detail.
  - Why: Keeps the PR description aligned with the commit history and avoids redundant elaboration.

- Before creating the PR, have the user review and approve the PR description.

### Create the PR

- Use the GitHub CLI to create a draft pull request:

```bash
gh pr create \
  --draft \
  --base <parent-branch> \
  --title "<header-line>" \
  --body-file "/path/to/scratch/pr_body.md" \
  --assignee "gsmendoza-narra-labs" \
  --label "CI-Ready"
```

- Set `--title` using the header line format from /gsm-general-commit.

- Set `--base` to the parent branch.
  - Parent branch: the branch this one was cut from (e.g. an upstream feature branch in a stack, not the repo default branch).
  - Why: Scope the PR to commits on this branch only, not work already covered on the parent.
