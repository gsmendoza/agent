---
name: gsm-draft-pr-review-responses
description: Draft and locally save responses to PR review comments from human or automated reviewers.
user_invocable: true
---

# GSM > Draft PR Review Responses

## Description

- Draft and locally save responses to PR review comments from human or automated reviewers.

## Prerequisites

- The user has addressed valid feedback (e.g. via `/gsm-plan-from-feedback`) and committed the changes.

## Workflow

### 1. Identify review comments

- Retrieve review comments on the PR (e.g. using `gh pr view` or `gh api`).

- Separate comments into:
  - Valid feedback: addressed by commits on the branch.
  - Invalid or skipped feedback: requires a rebuttal explanation.

### 2. Compose draft responses

- For valid feedback (addressed by a commit):
  - Use the commit log for the commit addressing that feedback.
    - Format: output of `git log -1 --no-decorate <commit-sha>`.
      - Why: GitHub automatically links the commit SHA and code-blocks the commit message.

- For invalid or skipped feedback (rebuttals):
  - For automated or bot reviewers:
    - Tone: neutral, impersonal, and factual.
      - Why: Matches the tone of an automated review.

    - Append AI attribution to the response.

  - For human reviewers:
    - Tone: collaborative and constructive.
      - Why: Fosters productive discussion without assuming the author's approach is definitively superior or that the reviewer's concern is invalid.

    - Best practices for rebuttals:
      - Acknowledge intent: Validate why the reviewer's suggestion makes sense in general before explaining why it does not apply here.
      - Share context and constraints: Frame the response around the specific context, constraints, or trade-offs the author considered, rather than stating the reviewer is wrong.
      - Use softened, non-prescriptive language: Prefer phrasing like "My thinking was...", "I opted for...", or "I leaned towards..." over definitive assertions like "This is better" or "That is unnecessary".
      - Invite dialogue: Leave the door open for follow-up with phrases like "Let me know what you think" or "Open to adjusting this if you see it differently".

    - Do not append AI attribution.
      - Why: Keeps responses to teammates authentic and conversational.

### 3. Save the draft

- Format the draft with a section for each review comment:
  - Include the comment URL or ID and a brief summary of the original feedback.

  - Present the proposed response as regular Markdown text.
    - Do not wrap the response in a markdown code block.
      - Why: Wrapping in code blocks prevents soft-wrapping and renders the text as code when viewed in HTML.

- Invoke `/gsm-save` with the suggested slug `pr-review-responses-<pr-number>` to save the draft locally.
  - Provide the user with the generated draft and the link to the saved file.
