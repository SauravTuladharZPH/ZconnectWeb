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