---
name: gsm-toolchest-rails-plan-jira-ticket
description: Invoke when preparing a plan for a toolchest-rails JIRA ticket
user_invocable: true
---

# GSM > Toolchest Rails > Plan JIRA Ticket

## Goal

- Prepare a plan for implementing a Toolchest-Rails JIRA ticket.

## Input

- JIRA ticket number (or key).

## Process

- Use `jira` CLI to fetch ticket details.
  - Use `JIRA_API_TOKEN` from `.env` to authenticate.

- If the ticket is part of an epic, fetch the details of the epic too.
  - Why: The epic provides background and acceptance criteria that may not be repeated in the child ticket.

- Invoke `/gsm-plan` to outline the step-by-step implementation plan.
