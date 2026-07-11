# AIGBD Alpha Stable Workflow Reference

Project root: `D:\AI\BrowserUse`

## Components

| Layer | Stable location | Responsibility |
|---|---|---|
| Entry point | `main.py` | Runs the complete local workflow |
| Launcher | `launcher/launch_aigbd.py` | Health check, port selection, backend start, dashboard open |
| Backend | `backend/server.py` | FastAPI `/health`, `/run-workflow`, summary, preview, folder/file actions |
| Dashboard | `dashboard/index.html`, `dashboard/app.js`, `dashboard/style.css` | Local business workspace |
| Knowledge | `knowledge/` | Product, country, platform, industry data and engine |
| Search | `workflow/search.py`, `platforms/google.py`, `platforms/google_maps.py` | Up to 50 Google and 50 Maps candidates, scoring, Primary/Backup, merge and dedupe |
| Qualification | `workflow/02_qualify.py`, `brain/` | Rule-based classification and scoring |
| Analysis | `workflow/website_analyzer.py`, `workflow/customer_background.py`, `workflow/customer_classification.py` | Public company evidence and customer-role signals |
| Contact | `workflow/contact_intelligence.py`, `contact_sources/` | Public contact consolidation |
| Strategy | `workflow/sales_strategy.py`, `workflow/decision_intelligence.py` | Entry, priority, and next-action recommendations |
| Outreach | `workflow/email_intelligence.py`, `workflow/email_generator.py` | Draft-only customer-focused emails |

## Main outputs

The workflow writes CSVs under `output/` including:

- `all_platform_results.csv`
- `qualified_opportunities.csv`
- `company_profiles.csv`
- `customer_background.csv`
- `contact_intelligence.csv`
- `sales_strategy.csv`
- `decision_intelligence.csv`
- `email_intelligence.csv`

Draft files are written under `emails/` as Markdown, HTML, and (when available) DOCX. They are never sent automatically.

## Search candidate pool

- Google Search: collect up to 50 valid organic company candidates across a safe maximum of five pages.
- Google Maps: collect up to 50 valid public business candidates through conservative scrolling.
- Score each platform independently. Use `result_limit=10` by default for each platform's Primary group.
- Retain remaining candidates as Backup, sort each group by `candidate_score`, and merge duplicate companies across Google and Maps.
- Preserve Maps phone, address, rating, review count, category, and Maps URL when merging with organic website evidence.
- Treat fewer than 50 public results as a valid partial pool, not a program failure.

## One-click launcher contract

The launcher uses `D:\AI\BrowserUse\.venv\Scripts\python.exe`. It tries ports 8001–8005, reuses an already healthy AIGBD backend, and avoids `uvicorn --reload` on Windows. Logs are in `logs/` and must not contain API keys.

Stop only the launcher-owned backend:

```powershell
cd D:\AI\BrowserUse
.\\Stop_AIGBD.bat
```

## Stable test checklist

1. Do not edit `.env`.
2. Run `launcher\\health_check.py`.
3. Start with the desktop shortcut or `Launch_AIGBD.bat`.
4. Open the printed Dashboard URL.
5. Enter a product keyword, target country, and result limit.
6. Click `Run Full Workflow` once and keep the page open.
7. Confirm success state, summary, preview, CSVs, and draft emails.
8. If it fails, record stage and non-secret traceback from `logs\\aigbd_backend.log`.
9. Keep all output CSV files closed in Excel while a workflow is running.

## Business guardrails

The system supports international B2B prospecting for mechanical/metal products. Prioritize distributors, importers, OEMs, and relevant buyers; treat marketplaces/directories as evidence rather than verified customers. Keep outreach concise, professional, customer-focused, and draft-only.
