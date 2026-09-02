---
name: gsm-respond-to-automated-pr-review
description: Invoke when responding to automated PR review after the agent has assessed the feedback and implemented its recommendations.
user_invocable: true
---

# GSM > Respond to Automated PR Review

## Goal

- Respond to automated PR review comments after assessing feedback and implementing recommendations.

## Prerequisites

- The user has invoked `/gsm-plan-from-feedback` and implemented any agreed-upon recommendations.

- The user has pushed the changes to the remote branch.

## Process

- Prepare a draft response for each review comment:
  - If the feedback was assessed as valid:
    - Use the commit log for the commit addressing that feedback.
      - Format: output of `git log -1 --no-decorate <commit-sha>`.
        - Why: GitHub automatically links the commit SHA and code-blocks the commit message.

  - If the feedback was assessed as invalid:
    - Draft a rebuttal response.
      - Use an impersonal tone.
        - Why: matches the tone of an automated review.

      - Append AI attribution to the response.

- Present the draft responses and wait for user approval.

- Once approved, submit each response to its corresponding review comment.

## Example Commit Log

commit c7b3753a96a5ff2be08e8c0ccce2c1f80e9a9e8d
Author: George Mendoza <george@narralabs.com>
Date:   Wed Sep 2 14:56:59 2026 +0800

    ATC-2881 FEATURE: Add REWRITE_NAME_BY_KEY reference constant

    Add a constant mapping the existing rewrite_category enum keys
    (new_customer, existing_customer) to their corresponding default
    Rewrite tag names. It isn't wired into any lookup yet - it exists to
    point future developers toward looking up these tags by key rather
    than by their user-facing (and renameable) name.

    Co-Authored-By: Claude Sonnet 5 <noreply@anthropic.com>
    Claude-Session: https://claude.ai/code/session_01R9KmnxBeLuj9BxHnLag2Hu
