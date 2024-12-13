*** Settings ***
Library    SeleniumLibrary
Library    ../../Helper/ExcelKeywords.py
Library    RetryFailed    3    5
Resource    ../../Helper/common.robot
Resource    ../../Pages/LoginPage.robot
Resource    ../../Pages/HomePage.robot
Test Teardown    Close Browser


*** Test Cases ***
Validate Menu are present in Homepage
    Initialize Login Data
    Open Login Page     ${URL}
    Enter Group Code    ${GROUP_CODE}
    Agree Terms
    Enter Credentials   ${USERNAME}    ${PASSWORD}
    Click Login
    Skip MFA Setup
    Cancel MFA Prompt
    Verify Search Bar
    ${menu_items}=    Read Homepage Test Data
    Log Many          @{menu_items}  # Debugging to ensure correct data
    Validate Menu Items On Homepage  @{menu_items}

Validate Menu Items On Homepage Opened Successfully
    Initialize Login Data
    Open Login Page     ${URL}
    Enter Group Code    ${GROUP_CODE}
    Agree Terms
    Enter Credentials   ${USERNAME}    ${PASSWORD}
    Click Login
    Skip MFA Setup
    Cancel MFA Prompt
    Verify Search Bar
    ${menu_data}=    Read Homepage Menu Test Data
    Log Many          @{menu_data}  # Debugging to ensure correct data
    Validating homepage menu heading and url when menu items are opened  ${menu_data}