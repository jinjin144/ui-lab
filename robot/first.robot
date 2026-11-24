*** Settings ***
Library    SeleniumLibrary
Test Teardown    Close Browser

*** Variables ***
${BROWSER}    chrome
${EXPECTED_TITLE}    Web form

*** Test Cases ***
The Web Form Opens
    [Documentation]    Open the web form and check its title.
    Open Browser    https://www.selenium.dev/selenium/web/web-form.html    ${BROWSER}
    ...    service=executable_path=r'%{CHROMEDRIVER}'
    Title Should Be    ${EXPECTED_TITLE}
