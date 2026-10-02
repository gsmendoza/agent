---
name: gsm-submit-pr-review-responses
description: Submit drafted pull request review responses to GitHub.
user_invocable: true
---

# GSM > Submit PR Review Responses

## Description

- Submit drafted pull request review responses to GitHub.

## Workflow

### 1. Preflight

- Proceed with submission only when all of the following are true. Otherwise, inform the user and ask for instructions:
  - The branch changes addressing valid feedback have been pushed to the remote branch.
    - Why: Referenced commit SHAs must exist on the remote repository for GitHub review links to work.

  - A PR review response draft is available in conversation context or from a file link previously created by `/gsm-save`.
    - Why: Responses should be drafted and reviewed before posting.

### 2. Prepare responses

- If reading from a draft file, load the draft contents.
- Extract each review comment target (comment ID or URL) and its corresponding response body.

### 3. Submit responses

- Submit each response to GitHub:
  - For line-level review comments, reply directly to the comment thread:
    ```bash
    gh api "repos/<owner>/<repo>/pulls/<pr_number>/comments/<comment_id>/replies" -f body="<response-body>"
    ```

  - For top-level PR comments, post as a PR issue comment:
    ```bash
    gh pr comment <pr_number> --body "<response-body>"
    ```

- Provide the user with links or confirmation of the submitted responses.
