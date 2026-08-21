---
name: maintain-global-sales-workbench
description: Maintain and publish an evidence-backed international sales workbench from Outlook emails, uploaded spreadsheets or quote attachments, and an existing Sites project. Use when Codex must create, sync, audit, or update customer lists, CRM insights, quotations, customer grades, follow-up plans, source links, email-derived company websites, or daily verification results without inventing missing business data.
---

# Maintain Global Sales Workbench

Maintain the workbench as an auditable business snapshot. Treat email, attachments, and verified public pages as evidence; treat analysis and recommendations as labeled inference.

## Load the operating references

- Read [references/workbench-production-workflow.md](references/workbench-production-workflow.md) before creating or restructuring the workbench.
- Read [references/data-contract.md](references/data-contract.md) before importing, merging, grading, pricing, or validating records.

## Follow the workflow

1. Open the existing Site through the Sites lifecycle before inspecting or changing source. Create a Site only when none exists.
2. Inventory the current modules, source timestamps, customer aliases, quote rules, and deployment state.
3. Read connected Outlook messages and supplied attachments. Preserve message links, filenames, dates, and exact source fields.
4. Normalize records using the data contract. Merge only identities supported by names, domains, signatures, or explicit business evidence.
5. Update modules in this order: mailbox snapshot, customer list, customer management, quotation management, project follow-up, audit status.
6. Keep missing values blank. Never calculate, translate, infer, or convert a business field unless the source or an explicit rule authorizes it.
7. Validate source coverage, duplicate handling, ordering, totals, lowest-price comparisons, and links.
8. Publish through a Sites checkpoint and verify the terminal deployment status before reporting success.

## Apply non-fabrication rules

- Do not create customers, contacts, phone numbers, emails, prices, currencies, quantities, totals, Incoterms, payment terms, orders, feedback, or countries without evidence.
- Derive a company website only from a non-public email domain when requested. Label it as email-domain-derived; do not claim the site is verified or reachable without checking it.
- Keep Outlook, Gmail, Yahoo, Hotmail, Live, QQ, 126, 163, iCloud, and other public-email domains out of company website fields.
- Compare product prices only when customer, product/model key, currency, and normalized unit all match. Retain the lowest price; use the newer record only to break an equal-price tie.
- Sort customer groups by grade A to D. Within equivalent groups, use the documented amount, frequency, and latest-date rules.
- Distinguish “not found in current sources” from “confirmed absent.”

## Handle email evidence

- Prefer explicit sender/recipient addresses and signature details.
- Map an email to an existing customer only when the message subject, participant name, signature, or enterprise domain supports the match.
- Preserve secondary addresses as additional contact details rather than silently replacing the primary address.
- Ignore tracking-wrapper addresses such as domains ending in `.getnotify.com` when the underlying real address is available.
- Keep the original Outlook message link on every email-enriched record.

## Produce the completion report

Report only:

- records added or changed;
- unchanged modules checked;
- unresolved exceptions;
- verified Site URL.

If nothing changed, record the verification time and result without fabricating activity.
