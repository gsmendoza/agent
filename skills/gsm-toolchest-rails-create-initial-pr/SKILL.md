---
name: gsm-toolchest-rails-create-initial-pr
description: Invoke when the user requests to create a pull request, draft PR, or push the current branch.
user_invocable: true
---

# GSM > Toolchest Rails > Create Initial PR

## Goal

- Push the local branch and create a draft pull request on GitHub.

## Steps

### Push the branch

```bash
git push origin <branch-name>
```

### Write the PR body

- Write the PR description to a temporary file in the scratch directory (e.g. `/home/gsmendoza/.gemini/antigravity-cli/brain/<conversation-id>/scratch/pr_body.md`).
- Use this template:

```markdown
## Ticket

https://agencytoolchest.atlassian.net/browse/<TICKET_ID>

## Summary

<High-level summary of what the branch implements.>

## Demo/Screenshots

TODO

## Seed Data

TODO
```

- Omit test changes in the summary unless they are the primary focus of the PR.

### Create the PR

- Use the GitHub CLI to create a draft pull request:

```bash
gh pr create \
  --draft \
  --title "<TICKET_ID>: <Title description>" \
  --body-file "/path/to/scratch/pr_body.md" \
  --assignee "gsmendoza-narra-labs" \
  --label "CI-Ready"
```
