# Evidence index

- `manual-admin.jpg`: Part 0's assistant-operated UI run. The created pizza was absent; step 7 is recorded as FAIL.
- `robot-intentional-failure/`: required incorrect-title demonstration, expected FAIL. Corrected tests and passing results are in `../robot/results/web-form/`.
- `cypress-intentional-failure.txt` and `cypress-intentional-failure/`: required incorrect-title demonstration, expected FAIL. The checked-in web-form spec has the correct title.
- `cypress-run1.txt` and `cypress-run2.txt`: both complete passing runs, including recorded pizza response fields and the matching admin line.
- `../robot/results/run1/` and `run2/`: both passing QP-01 runs, each with four screenshots and HTML/XML results.
- `../cypress/cypress/screenshots/` and `videos/`: final full Cypress run's three screenshots and two videos.

Robot's incorrect title was supplied as a command-line variable:

```powershell
python -m robot -d ../evidence/robot-intentional-failure -v BROWSER:headlesschrome -v 'EXPECTED_TITLE:Web Form' first.robot
```

Cypress's incorrect-title demonstration temporarily changed the first title expectation from `Web form` to `Web Form`, ran the web-form spec with `video=false` and a separate screenshot directory, then restored `Web form` before the full runs. Evidence of expected failures is intentionally retained separately from final passing runs.

The optional second-browser task was not attempted. Test setup generated configuration files directly instead of using the Cypress configuration wizard; the same runtime verified successfully and executed both specs. ChromeDriver is configured in the test process environment rather than saved as a permanent Windows user setting.
