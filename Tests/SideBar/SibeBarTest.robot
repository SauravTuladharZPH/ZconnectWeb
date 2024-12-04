*** Settings ***
Library    SeleniumLibrary
Library    ../../Helper/ExcelKeywords.py
Resource    ../../Helper/common.robot
Resource    ../../Pages/LoginPage.robot
Resource    ../../Pages/HomePage.robot
Resource    ../../Pages/SideBarPage.robot
Library    Collections
Test Teardown    Close Browser

*** Test Cases ***
Validate Sidebar Menu Items
    Initialize Login Data
    Open Login Page     ${URL}
    Enter Group Code    ${GROUP_CODE}
    Agree Terms
    Enter Credentials   ${USERNAME}    ${PASSWORD}
    Click Login
    Skip MFA Setup
    Cancel MFA Prompt
    Verify Search Bar
    #Sleep    3s
    Click SideBar
    Sleep    8s

    #Wait Until Element Is Visible    (//img[@class="css-9pa8cd"])[position() >= 86 and position() <= 93]/preceding::div[2]    timeout=30    error=Menus did not become visible
    ${actual_menus}=    Get WebElements Texts    (//img[@class="css-9pa8cd"])[position() >= 86 and position() <= 93]/preceding::div[2]
    ${expected_menus}=  Read Expected Menus From Excel    ${EXCEL_FILE}    ${SIDEBAR_SHEET_NAME}
    Validate Sidebar Menus         ${actual_menus}    ${expected_menus}

