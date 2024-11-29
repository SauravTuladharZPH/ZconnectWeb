*** Settings ***
Library    SeleniumLibrary
Library    /Users/saurav.tuladhar/Automation/RobotProject/Helper/ExcelKeywords.py
Resource   /Users/saurav.tuladhar/Automation/RobotProject/Helper/common.robot
Resource   /Users/saurav.tuladhar/Automation/RobotProject/Pages/LoginPage.robot
Resource   /Users/saurav.tuladhar/Automation/RobotProject/Pages/HomePage.robot


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

Validate All Menu Items On Homepage
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
    Validate All Menu Items On Homepage  @{menu_data}