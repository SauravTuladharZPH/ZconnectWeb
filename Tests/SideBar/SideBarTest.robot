*** Settings ***
Library    SeleniumLibrary
Library    ../../Helper/ExcelKeywords.py
Resource    ../../Helper/common.robot
Resource    ../../Pages/LoginPage.robot
Resource    ../../Pages/HomePage.robot
Resource    ../../Pages/SideBarPage.robot
Library    Collections
#Test Teardown    Close Browser

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
    Sleep    5s
    Click SideBar
    Sleep    15s

#    # Step 3: Fetch actual menu items
#    ${actual_menus}=    Get WebElements Texts    (//div[contains(@class,'css-901oao')])[position() >= 247 and position() <= 254]
#
#    # Step 4: Fetch expected menu items from Excel
#    ${expected_menus}=  Read Expected Menus and Submenus From Excel    ${EXCEL_FILE}    ${SIDEBAR_SHEET_NAME}
#    ${expected_keys}=   Create List    @{expected_menus.keys()}

    # Step 5: Validate main menu items
    Validate Sidebar Menu Items

    # Step 6: Validate submenus for each menu item
    FOR    ${menu}    IN    @{expected_keys}
        Validate Submenu    ${menu}    ${expected_menus[${menu}]}
    END
