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
    Sleep    3s
    Click SideBar
    Sleep    3s

    ${menu_data}=    Read Expected Menus and Submenus From Excel    ${EXCEL_FILE}    ${SIDEBAR_SHEET_NAME}
    Log    ${menu_data}

    # Iterate over each main menu
    FOR    ${main_menu}    IN    @{menu_data.keys()}
        ${menu_details}=    Get From Dictionary    ${menu_data}    ${main_menu}
        Validate Sidebar Menu Items    ${main_menu}    ${menu_details}
    END


Logout Test
    Initialize Login Data
    Open Login Page     ${URL}
    Enter Group Code    ${GROUP_CODE}
    Agree Terms
    Enter Credentials   ${USERNAME}    ${PASSWORD}
    Click Login
    Skip MFA Setup
    Cancel MFA Prompt
    Verify Search Bar
    Sleep    3s
    Click SideBar
    Sleep    3s
    Logout Validations
