*** Settings ***
Library    SeleniumLibrary
Library    ../Helper/ExcelKeywords.py
Resource    ../Helper/common.robot


*** Keywords ***
Get WebElements Texts
    [Arguments]    ${locator}
    ${elements}=   Get WebElements    ${locator}
    ${texts}=      Create List
    FOR    ${element}    IN    @{elements}
        ${text}=    Get Text    ${element}
        Append To List    ${texts}    ${text}
    END
    RETURN    ${texts}

Click SideBar
    Wait Until Element Is Visible    //div[@id="menu_icon"]    timeout=30    error=SideBar did not become visible
    Click Element    //div[@id="menu_icon"]

#Validate Submenu
#    [Arguments]    ${main_menu}    ${expected_submenus}
#    Click Element    xpath=//div[text()='${main_menu}']  # Click the main menu
#
#    ${actual_submenus}=    Get WebElements Texts    (//div[text()='${main_menu}']/following-sibling::div//div[contains(@class,'submenu-class')])
#    Validate Sidebar Menus    ${actual_submenus}    ${expected_submenus}

Validate Submenu
    [Arguments]    ${main_menu}    ${expected_submenus}
    Execute JavaScript    var element = document.evaluate("//div[text()='${main_menu}'", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; if (element) { element.setAttribute('type', 'button'); element.style.border='3px solid red'; element.dispatchEvent(new MouseEvent('click', { bubbles: true, cancelable: true })); }

    Click Element    xpath=//div[text()='${main_menu}']
    FOR    ${submenu}    IN    @{expected_submenus}
        ${submenu_xpath}=    Set Variable    //div[text()='${main_menu}']/following-sibling::div//div[contains(@class,'${submenu}')]
        ${actual_submenus}=    Get WebElements Texts    ${submenu_xpath}
        Log    Found submenu: ${actual_submenus}
        Validate Sidebar Menus    ${actual_submenus}    ${submenu}
    END


Validate Sidebar Menu Items
    # Validate main menu items
    ${actual_menus}=    Get WebElements Texts    (//div[contains(@class,'css-901oao')])[position() >= 247 and position() <= 254]
    ${expected_menus}=  Read Expected Menus and Submenus From Excel    ${EXCEL_FILE}    ${SIDEBAR_SHEET_NAME}
    ${expected_keys}=   Create List    @{expected_menus.keys()}

    Validate Sidebar Menus         ${actual_menus}    ${expected_keys}

    # Validate submenus for each menu item
    FOR    ${menu}    IN    @{expected_keys}
        Validate Submenu    ${menu}    ${expected_menus['${menu}']}
    END