*** Settings ***
Library    SeleniumLibrary
Resource    ../Helper/common.robot


*** Variables ***
${SKIP_BUTTON_LOCATOR}    //div[contains(text(),'Skip')]
${MFA_CANCEL_PROMPT_LOCATOR}    //p[contains(text(),'Are you sure you want to cancel MFA setup?')]//following::span[1]
${SEARCH_BAR_LOCATOR}    //input[@placeholder="How can we help?"]

*** Keywords ***
Skip MFA Setup
    Wait Until Element Is Visible    ${SKIP_BUTTON_LOCATOR}    timeout=30    error=Skip button did not become visible
    Click Element    ${SKIP_BUTTON_LOCATOR}

Cancel MFA Prompt
    Wait Until Element Is Visible    ${MFA_CANCEL_PROMPT_LOCATOR}    timeout=30    error=Cancel MFA prompt did not become visible
    Click Element    ${MFA_CANCEL_PROMPT_LOCATOR}

Verify Search Bar
    Wait Until Element Is Visible    ${SEARCH_BAR_LOCATOR}    timeout=30    error=Search bar did not become visible
    Page Should Contain    DAMON MICHAEL!

Validate Menu Items On Homepage
    [Arguments]    @{menu_items}
    FOR    ${item}    IN    @{menu_items}
        Log    Validating menu item: ${item}
         Wait Until Element Is Visible    //span[text()='${item}']    timeout=30    error=Menu item ${item} did not become visible
        Element Should Be Visible    //span[text()='${item}']
    END


Validating homepage menu heading and url when menu items are opened
    [Arguments]    ${menu_data}
    FOR    ${menu_item}    IN    @{menu_data}
        ${menu_name}=         Set Variable    ${menu_item["menu_name"]}
        ${expected_heading}=  Set Variable    ${menu_item["expected_heading"]}
        ${expected_url}=      Set Variable    ${menu_item["url"]}
        Log    Validating menu item: ${menu_name}
        Log    Validating menu item heading: ${expected_heading}
        Log    Validating menu item URL: ${expected_url}
        # Validate the menu item is visible and clickable
        Wait Until Element Is Visible    //span[text()='${menu_name}']    timeout=30    error=Menu item ${menu_name} did not become visible
        Element Should Be Visible       //span[text()='${menu_name}']
        Sleep    1s
        Click Element                   //span[text()='${menu_name}']
        Sleep    2s
        Run Keyword If    '${menu_name}' == 'TelaDoc'    Validate TelaDoc Tab
        Run Keyword If    '${menu_name}' != 'TelaDoc'    Validate Menu Navigation    ${menu_name}    ${expected_heading}    ${expected_url}
    END

Validate TelaDoc Tab
    ${windows}=    Get Window Handles
    ${window_count}=    Get Length    ${windows}
    Should Be Equal As Numbers    ${window_count}    2
    Switch Window    ${windows[1]}
    Close Window
    Switch Window    ${windows[0]}

Validate Menu Navigation
    [Arguments]    ${menu_name}    ${expected_heading}    ${expected_url}
    # Validate Page Heading
    IF    '${expected_heading}' != ''
        Wait Until Element Is Visible    //div[text()='${expected_heading}']    timeout=30    error=Expected heading ${expected_heading} not found for menu item ${menu_name}
        Element Text Should Be    //div[text()='${expected_heading}']    ${expected_heading}
    END
    # Validate URL
    IF    '${expected_url}' != ''
        ${current_url}=    Get Location
        Run Keyword If    "${expected_url}" not in "${current_url}"    Fail    URL validation failed for ${menu_name}. Expected part: ${expected_url}, Found: ${current_url}
    END
    # Go back to the homepage
    Go Back