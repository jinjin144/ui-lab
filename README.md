# Automated UI Testing Lab

Selected tools: **Part 3, Robot Framework**, and **Part 4, Cypress**.

Published to https://github.com/jinjin144/ui-lab after review authorization. MyCourses submission is not recorded. See [RESULTS.md](RESULTS.md) for observations, run results, and reflection answers, and [REVIEW.md](REVIEW.md) for the review checklist.

## Setup on Windows

Requirements: Chrome, Python 3.10+, Node.js 22+, npm, and Git. From this repository's root, run:

```powershell
./tools/setup.ps1
```

The setup downloads the matching official ChromeDriver outside this repository, sets `CHROMEDRIVER` in the current terminal, creates an isolated Python environment, and installs the locked dependencies. For an installation elsewhere, pass `-ChromePath 'C:/path/to/chrome.exe'`. In a new terminal, set `$env:CHROMEDRIVER` to your downloaded driver's absolute path again. The driver is deliberately not committed.

## Robot Framework — `robot/`

Contains the initial title test, the web form test, and QP-01 with reusable page keywords in `resources/quickpizza.resource`. Run all three from the repository root:

```powershell
./tools/run-robot.ps1
```

The equivalent command inside `robot/`, after activating `.venv`, is `robot -d results/review -v BROWSER:headlesschrome first.robot web_form.robot pizza_scenario.robot`. The required two QP-01 runs are preserved in `robot/results/run1/` and `run2/`; each contains an HTML report, step log, XML output, and four screenshots. The corrected form tests are in `robot/results/web-form/`.

## Cypress — `cypress/`

Contains two independent specs, reusable admin login, live request/response checks, and screenshot/video settings. Run both specs from the repository root:

```powershell
./tools/run-cypress.ps1
```

Inside `cypress/`, the standard command is `npx cypress run --browser chrome`. On this machine Chrome is installed per user, so the wrapper passes its absolute executable path because Cypress's automatic discovery only found Edge and Electron. If needed, pass `-ChromePath 'C:/path/to/chrome.exe'` to the wrapper.

Final full-run evidence is in `cypress/cypress/screenshots/` and `cypress/cypress/videos/`; terminal transcripts for both runs are in `evidence/`. Cypress replaces its default screenshots/videos on each run, so review the saved evidence before rerunning. Required intentional failure demonstrations are kept separately in `evidence/` and are not part of the passing suite.

## Test scope and shared-site rules

QP-01 checks the initial heading, advanced controls, all entered restrictions, the returned name/tool/calories, anonymous rating rejection, admin login, and the matching admin entry. All seven steps use one browser session. Names use `Lab Pizza yyyyMMdd-HHmmss`, waits use page conditions or network completion, and tests do not use fixed sleeps or retry loops. Run only when necessary. Never click **Clear Ratings** on the shared default account.

The public practice credentials `admin/admin` and dummy form password are lab data. Do not replace these with private project credentials in committed source. The vegetarian checkbox is verified, but a separate check of the generated pizza's vegetarian status is proposed in Part B, as requested by the exercise.

## Review and submission

Review `RESULTS.md`, the source code, reports, screenshots, and videos. The manual Part 0 run has a genuine step 7 failure recorded, while both Robot QP-01 runs pass; this discrepancy is retained rather than rewritten as a pass. Review the draft reflections against your own understanding before submission. After approval, create a **public** GitHub repository named `ui-lab`, push this repository, and submit its link on MyCourses by the deadline shown there.
