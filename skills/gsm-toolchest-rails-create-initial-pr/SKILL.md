---
name: gsm-toolchest-rails-create-initial-pr
description: Invoke when the user requests to create a pull request, draft PR, or push the current branch.
user_invocable: true
---

# GSM > Toolchest Rails > Create Initial PR

## Goal

- Push the local branch and create a draft pull request on GitHub.

## Steps

### Verify remote status

- If the branch has diverged from the remote branch, do not proceed with PR creation. Inform the user and ask for instructions.

### Write the PR body

- Write the PR description to a temporary file in the scratch directory (e.g. `/home/gsmendoza/.gemini/antigravity-cli/brain/<conversation-id>/scratch/pr_body.md`).
- Use this template:

```markdown
## Ticket

https://agencytoolchest.atlassian.net/browse/<TICKET_ID>

## Summary

<High-level summary of what the branch implements.>

## Additional changes

<Changes outside the ticket scope or that cross ticket boundaries. Omit this section if none.>

## Demo/Screenshots

TODO

## Seed Data

TODO
```

- Omit test changes in the summary unless they are the primary focus of the PR.

- Before creating the PR, have the user review and approve the PR description.

### Create the PR

- Use the GitHub CLI to create a draft pull request:

```bash
gh pr create \
  --draft \
  --base <parent-branch> \
  --title "<TICKET_ID>: <Title description>" \
  --body-file "/path/to/scratch/pr_body.md" \
  --assignee "gsmendoza-narra-labs" \
  --label "CI-Ready"
```

- Set `--base` to the parent branch.
  - Parent branch: the branch this one was cut from (e.g. an upstream feature branch in a stack, not the repo default branch).
  - Why: Scope the PR to commits on this branch only, not work already covered on the parent.
