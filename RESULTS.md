# UI lab results

Tool parts that I chose: **Part 3: Robot Framework** and **Part 4: Cypress**.

Review copy prepared with assistant-operated runs on 24 November 2026. All observed times are Asia/Bangkok (UTC+7). Published to GitHub after authorization; no MyCourses submission has been performed. Part B is a draft for the student's review.

## Part 0

- Step 0.1, Chrome version: **157.0.8103.79**, Windows x64.
- Step 0.3, ChromeDriver version: **157.0.8103.79**, downloaded from Google's official Chrome for Testing storage. The executable is outside the repository; test terminals received `CHROMEDRIVER` explicitly. No persistent user environment setting was changed.
- Step 0.4, locator of Pizza, Please!: `button[name="pizza-please"]` (CSS).
- Step 0.4, locator of Excluded tools: `select` (CSS).
- Step 0.4, locator of Must be vegetarian: `#default-checkbox` (CSS).
- Step 0.4, locator of Custom Pizza Name: `input#pizza-name` (CSS).
- Each of these four selectors matched exactly one element in the live page. `#floating_filled` matched **3** elements. The calories field was identified by `//label[normalize-space()='Max Calories per Slice']/preceding-sibling::input`.
- Step 0.5, pizza name, tool and calories of the run through the UI: **Lab Pizza 20261124-181506**, **Scissors**, **350 calories per slice**.
- Method: assistant-operated Chrome UI, one action block at a time; this was separate from the Robot and Cypress test suites. The user has not personally executed this run.

### QP-01 — A custom pizza reaches the admin list

Objective: check restrictions on a pizza recommendation, reject anonymous rating, and find the same pizza/tool in admin. Preconditions: QuickPizza reachable and not logged in on the customer page. Data: maximum 600 calories, exclude Knife, vegetarian selected, unique pizza name, public demo admin credentials `admin/admin`.

| Step | Action and expected result | Actual result | Pass or fail |
|---|---|---|---|
| 1 | Open home; heading is Looking to break out of your pizza routine? | Exact heading appeared. | Pass |
| 2 | Enable Advanced; four specified fields appear. | Calories, excluded tools, vegetarian and custom name controls appeared. | Pass |
| 3 | Set 600, Knife, vegetarian and unique name; controls reflect the input. | 600 displayed, Knife selected, checkbox checked, Lab Pizza 20261124-181506 entered. | Pass |
| 4 | Click Pizza, Please!; matching name, non-Knife tool and calories <=600. | Correct name, Scissors, 350 calories per slice. | Pass |
| 5 | Click Love it! without login; Please log in first. appears. | Exact message appeared after the request completed. | Pass |
| 6 | Open /admin and sign in; Latest pizza recommendations appears. | Sign in succeeded using the prefilled demo values; expected heading appeared. | Pass |
| 7 | Find the created name and compare its tool with step 4. | The 15 displayed admin entries did not contain the created name, including after one Refresh. | **Fail** |

The manual UI run therefore has an overall **FAIL**, not a fabricated pass. Evidence: [manual admin screenshot](evidence/manual-admin.jpg). The cause of the missing entry was not established; a server/session routing difference is a possible explanation, not a confirmed diagnosis. Both subsequent Robot runs and both Cypress runs exercise the same admin comparison with independent fresh sessions; their actual outcomes are recorded below.

## Part 3: Robot Framework

- `robot --version`: **Robot Framework 7.5.1 (Python 3.12.10 on win32)**.
- SeleniumLibrary **6.9.0**, Selenium **4.54.0**. Complete installed Python dependency versions are in `robot/requirements-lock.txt`.
- Step 3.2, failure message for the wrong title: **Title should have been 'Web Form' but was 'Web form'.** One test failed as intended. Evidence: `evidence/robot-intentional-failure/`.
- The expected title was restored to `Web form`. `first.robot` and `web_form.robot` then both passed: **2 tests, 2 passed, 0 failed**, in `robot/results/web-form/`.
- During development an extra radio assertion incorrectly compared the DOM value `on` to the element id `my-radio-2`. It was repaired to assert the checked state of `id:my-radio-2`; the corrected web form test passes.
- Step 3.8, run 1: **PASS, 1 test, 1 passed, 0 failed; 18.632409 s** suite elapsed time; **Lab Pizza 20261124-181715**, **Pizza cutter**, **425 calories**. Evidence: `robot/results/run1/`.
- Step 3.8, run 2: **PASS, 1 test, 1 passed, 0 failed; 11.822655 s** suite elapsed time; **Lab Pizza 20261124-181816**, **Scissors**, **375 calories**. Evidence: `robot/results/run2/`.
- Each required run contains `output.xml`, `log.html`, `report.html` and four images for steps 3, 4, 5 and 7. Screenshots confirm the entered restrictions, recommendation, login-needed message and matching admin entry.

## Part 4: Cypress

- `node --version`: **v24.20.0**; `npm --version`: **11.19.0**; installed Cypress package/runtime: **16.2.1**.
- Chrome was installed at `%LOCALAPPDATA%/Google/Chrome/Application/chrome.exe`. Cypress's automatic browser discovery did not list it, so runs used `--browser` with that executable's full path; the runner reported **Custom Chrome 157 (headless)**.
- Step 4.3, failure message for the wrong title: **Timed out retrying after 10000ms**, actual **'Web form'**, expected **'Web Form'**. The intentional run had 0 passing, 1 failing; source was then corrected back to `Web form`. Evidence: `evidence/cypress-intentional-failure.txt` and its separate screenshot directory.
- Step 4.6, first full run's POST `/api/pizza` response: **Pizza cutter, 375 calories**, `vegetarian: true`. The test also asserted HTTP 200, request `maxCaloriesPerSlice === 600`, and equality of the rendered tool/calories with the response.
- Step 4.7, first full run's matching admin entry: **Lab Pizza 20261124-182024 (tool=Pizza cutter, ingredients_number=5)**.
- Step 4.8, run 1: **PASS, 2 tests, 2 passed, 0 failed; 00:16 total**. QP-01 spec **00:12**, web form **00:03**; pizza **Lab Pizza 20261124-182024**. Transcript: `evidence/cypress-run1.txt`.
- Step 4.8, run 2: **PASS, 2 tests, 2 passed, 0 failed; 00:17 total**. QP-01 spec **00:13**, web form **00:04**; pizza **Lab Pizza 20261124-182228**, **Pizza cutter**, **575 calories**, response `vegetarian: true`. Admin entry: **Lab Pizza 20261124-182228 (tool=Pizza cutter, ingredients_number=8)**. Transcript: `evidence/cypress-run2.txt`.
- The final screenshot and video directories contain run 2, as Cypress replaces these directories between runs. There are three named QP-01 screenshots and two `.mp4` videos, one for each spec.
- Step 4.9 (optional): not attempted.

## Part B

### 1. Why locate calories through the label?

The inspected page had three inputs with the id `floating_filled`, so selecting that id cannot uniquely identify the calories field. The label-based locator found the intended input, and both Robot runs confirmed that its value was 600 before requesting a pizza. The page should assign a unique id such as `max-calories-per-slice` and connect the label using `for="max-calories-per-slice"`. This makes the locator unambiguous and improves the label's association for accessibility tools.

### 2. What kind of oracle compares the two tool values?

This is a consistency or relational test oracle: two views of the same created record must agree. Robot run 1 showed Pizza cutter in the recommendation, and its admin assertion required `(tool=Pizza cutter,` in the row containing the unique pizza name. It could catch a defect where the admin view displays a different stored tool from the tool returned to the customer. It cannot establish that both views are correct if both contain the same wrong value, so the separate non-Knife check remains necessary.

### 3. How could vegetarian status be checked?

Checking the vegetarian checkbox proves the requested setting, but does not prove the generated pizza is vegetarian. A supplementary Cypress assertion could require `response.body.vegetarian` to equal `true`; the recorded first full run returned true. A UI-focused test could instead inspect every displayed ingredient against an independent, authoritative ingredient classification. That approach needs reliable vegetarian metadata for the ingredients or a clear vegetarian indicator on the page, and a response flag alone could share a bug with the generation logic.

### 4. Compare the two tools used.

Robot used explicit condition keywords such as `Wait Until Element Is Visible` and `Wait Until Page Contains`, whereas Cypress retried queries/assertions and waited for the aliased pizza request. Robot's complete QP-01 runs took 18.632409 s and 11.822655 s; the first complete Cypress run took 16 s for two specs, so those totals do not represent equivalent workloads. Robot's scenario reads closely to the written steps because the details live in a resource file, while Cypress's inline JavaScript made the request/response comparison direct to express. Robot's expandable HTML log exposes each keyword and screenshot; Cypress provides a Command Log in a video plus named screenshots. Exact hands-on authoring time was not measured, so no numerical claim is made about writing speed; in this implementation Cypress needed extra work to specify the per-user Chrome path, and Robot needed an assertion correction for radio state.

### 5. Which tool would be used for Project 2?

The proposed choice is Cypress for Project 2's automated UI tests. First, its request interception checked that the submitted calories limit was 600 and compared the response with the rendered recommendation, giving evidence beyond successful clicks. Second, the full run automatically produced videos for both specs and named screenshots of the important QP-01 results, making failures easier to review. This choice assumes the project's required workflows can use one browser per test; separate simultaneously active browser sessions would favor another tool.

### 6. Part 3: Where would a changed calories locator be repaired?

The calories locator is held in `${MAX CALORIES}` in `robot/resources/quickpizza.resource`. If the page changes, updating that variable repairs both the field visibility check and the input/value checks that reference it. `pizza_scenario.robot` continues to call `Fill In The Pizza Request` with 600, Knife and the generated name, so it does not need to know the new selector. The two passing logs show these checks running through the same resource keyword, which is the practical benefit of keeping page details outside the scenario.

### 7. Part 4: Why must QP-01 remain one Cypress test?

Cypress clears browser state, including cookies, before each test under test isolation. QuickPizza uses a cookie to keep the browser on the same server, whose admin list contains that server's recommendations. If creation were one test and admin lookup another, losing that cookie could route the second test to a server that does not contain the created pizza, even if the name was passed along separately. Keeping all seven steps in the same `it` block retains the browser session, and the first full run successfully found the created pizza with the matching tool.
