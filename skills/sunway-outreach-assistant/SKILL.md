---
name: sunway-outreach-assistant
description: Operate, troubleshoot, and safely improve the existing local Sunway trade RFQ and outreach assistant. Use for this project’s RFQ imports and platform sync, customer review, draft generation, manual email approval, Outlook sending, reply sync, or local launch issues; do not use for unrelated prospecting or generic email writing.
---

# Sunway 外贸开发小助手

Use this skill for the existing local project at `D:\市场开发\外贸开发信小助手`. Treat the files and current database as the source of truth; historical reports may be stale. The app should remain local on `127.0.0.1` and keep its existing Node.js, Express, SQLite, collector, AI, and Outlook integrations.

## Operating rules

- The user is a nontechnical business operator. Handle code and diagnostics yourself; give short, numbered UI steps only when the user must log in, complete a CAPTCHA, authorize Microsoft, or make a business decision.
- Before changing production data or database schema, inspect the current implementation and make a consistent SQLite backup. Do not clear or rebuild production data. Preserve customer decisions, notes, RFQ history, email versions, send records, and encrypted Outlook credentials.
- Never print, copy into reports, or package `.env`, DPAPI-protected files, OAuth tokens, passwords, API keys, customer databases, backups, or live customer exports. Redact secrets and personal data from diagnostics.
- Keep customer consent, email-content approval, recipient confirmation, and sending as separate recorded decisions. Never approve a customer or email for the user. Do not send unless the user authorizes the exact message in the app’s per-message flow.
- Never automate bulk/sequence sends, retry an uncertain send, bypass a sign-in/CAPTCHA/paid feature, submit a quote, or consume platform credits. Use visible/authorized platform access only.
- Send RFQ reports externally only when the user explicitly names the recipient and asks to send them. Use the provider they specify; do not substitute the app's configured Outlook account for Gmail or another requested sender. Verify the batch from current database/API data first and distinguish a sent-folder record from recipient delivery.
- Report observable states precisely: platform read success is not the same as import success; SMTP acceptance is not proof of mailbox delivery; sent-folder lookup and a real recipient reply are separate evidence.
- Do not claim future scheduled runs succeeded. Distinguish configured schedules, manual runs, catch-up runs, and actual scheduled executions. Preserve Beijing schedule semantics (07:30, 14:00, 19:00) unless the user changes them.
- Prefer the existing UI, routes, collectors, schema, and launch scripts. Do not add a second application or alternate sending stack.
- Keep the RFQ review list newest-first by first discovery time (`discovered_at`), with a stable RFQ ID tie-break; use observation time only when discovery time is missing. Do not sort cross-platform by `posted_at`, whose formats and time zones differ.

## Choose the workflow

- For normal launch, status, or recovery, read [references/operations.md](references/operations.md).
- For RFQ import, collection, qualification, or review, read [references/rfq-workflow.md](references/rfq-workflow.md).
- For the RFQ review list, verify recent IDs through both SQLite and `GET /api/rfqs`; distinguish newly inserted RFQs from existing RFQs updated by this batch. After a sync, refresh the review list and confirm recent discoveries appear first.
- For approval, recipient confirmation, single-message sending, Outlook reconciliation, or reply sync, read [references/mail-workflow.md](references/mail-workflow.md).
- For code changes or diagnosis, read [references/code-map.md](references/code-map.md), then inspect the live implementation before editing.

## Standard completion report

State what changed, what the app/database/API actually showed, which parts were not exercised, and the smallest action the user must take. Never present a mock, historical report, stale output file, or syntax check as a live business result. Link local project files with absolute paths.
