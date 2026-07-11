---
name: aigbd-workflow
description: Operate, test, diagnose, and safely document the stable local AIGBD business-development workflow in D:\\AI\\BrowserUse, including the one-click launcher, FastAPI dashboard, search and qualification pipeline, customer intelligence, sales strategy, and draft email generation. Use when working on this project, starting its dashboard, validating a full run, or troubleshooting launcher/backend failures.
---

# AIGBD Workflow Skill

Use this skill as the operating contract for the stable AIGBD Alpha workflow. Preserve existing working behavior unless the user explicitly requests a scoped change.

## Safety and scope

- Never read, print, copy, or modify the value of `D:\\AI\\BrowserUse\\.env` or `DEEPSEEK_API_KEY`.
- Never send email, log in to external platforms, bypass CAPTCHA, or add a new platform unless explicitly requested.
- Keep Browser Use, Google Search/Maps, Knowledge, qualification, contact intelligence, sales strategy, decision intelligence, email intelligence, email generator, Dashboard API, and Dashboard UI unchanged for maintenance tasks.
- Treat current project files as the source of truth. Do not recreate earlier versions from memory.
- Before any change, state the target file and reason. Prefer additive, reversible edits.

## Stable workflow

The canonical entry point is `D:\\AI\\BrowserUse\\main.py`. Its stable sequence is:

1. `run_search_workflow(product, country, customer_type, result_limit=10)`
2. `run_qualification_workflow()`
3. `run_website_analyzer(limit=5)`
4. `run_customer_background_workflow()`
5. `run_customer_classification_workflow()`
6. `run_contact_intelligence()`
7. `run_sales_strategy_workflow(product)`
8. `run_decision_intelligence_workflow(product)`
9. `run_email_intelligence_workflow(product)`
10. `run_email_generator_workflow()`

The expected success output ends with `Browser automation completed successfully.` For outputs and troubleshooting, read [stable-workflow.md](references/stable-workflow.md).

## Start the system

Prefer the one-click launcher:

1. Double-click `C:\\Users\\Daixl\\Desktop\\AIGBD.lnk` if it exists.
2. Otherwise double-click `D:\\AI\\BrowserUse\\Launch_AIGBD.bat`.
3. The launcher runs health checks, selects an available port from 8001–8005, starts the virtual-environment Python/uvicorn backend without `--reload`, waits for `/health`, and opens the Dashboard.

Manual fallback:

```powershell
cd D:\\AI\\BrowserUse
.\\.venv\\Scripts\\python.exe launcher\\launch_aigbd.py
```

Open the URL printed by the launcher, often `http://127.0.0.1:8002/dashboard/index.html` when port 8001 is occupied.

## Validate a run

```powershell
cd D:\\AI\\BrowserUse
.\\.venv\\Scripts\\python.exe launcher\\health_check.py
.\\.venv\\Scripts\\python.exe main.py
```

Confirm exit code 0, success messages, regenerated CSV outputs, and draft files in `emails/`. Dashboard users should click `Run Full Workflow` once and keep the page open.

## Candidate pool rules

- Collect up to 50 valid Google Search candidates and 50 valid Google Maps candidates.
- Score Google Search and Google Maps independently on a 100-point scale.
- Mark each platform's top `result_limit` candidates as `Primary`; retain the remainder as `Backup`.
- Merge cross-platform matches by website domain, normalized company name, phone, then address.
- Process Primary candidates first. Keep Backup candidates in CSV without automatically applying high-cost website analysis unless Primary supply is insufficient.
- Stop immediately on CAPTCHA, blocked, verify, or unusual-traffic signals. Keep partial results and never bypass the challenge.

## Diagnose failures

- `Failed to fetch`: confirm Dashboard and uvicorn use the same port; use relative frontend fetch paths and check `/health`.
- `ModuleNotFoundError: backend`: run uvicorn from `D:\\AI\\BrowserUse`.
- `WinError 10048`: a port is occupied; let the launcher choose the next port or stop the launcher-owned backend with `Stop_AIGBD.bat`.
- Workflow HTTP 500: inspect `logs\\aigbd_backend.log`; report only non-secret `error_type`, `error_message`, stage, and traceback.
- `PermissionError` on `output/*.csv`: close Excel or any preview holding the CSV. Google Search writes a timestamped `google_results_latest_*.csv` fallback so the workflow can continue when the standard file is locked.
- Chrome/package failures: run the launcher health check; do not alter `.env`.

## Change discipline

For requested changes, inspect current imports and output schemas first, patch only named file(s), run `py_compile` for changed Python files, then run the smallest relevant test. For workflow changes, finish with `main.py` and report exit code and generated outputs. Use absolute file paths in handoff notes.
