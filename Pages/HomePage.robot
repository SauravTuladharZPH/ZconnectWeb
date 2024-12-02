*** Settings ***
Library    SeleniumLibrary
Resource    ../Helper/common.robot


*** Variables ***
${SKIP_BUTTON_LOCATOR}    //div[contains(text(),'Skip')]
${MFA_CANCEL_PROMPT_LOCATOR}    //p[contains(text(),'Are you sure you want to cancel MFA setup?')]//following::span[1]
${SEARCH_BAR_LOCATOR}    //input[@placeholder="How can we help?"]
#${HOMEPAGE_MENU_ITEMS}    //div[text()='${item}']

*** Keywords ***
Skip MFA Setup
    Wait Until Element Is Visible    ${SKIP_BUTTON_LOCATOR}    timeout=120    error=Skip button did not become visible
    Click Element    ${SKIP_BUTTON_LOCATOR}

Cancel MFA Prompt
    Wait Until Element Is Visible    ${MFA_CANCEL_PROMPT_LOCATOR}    timeout=120    error=Cancel MFA prompt did not become visible
    Click Element    ${MFA_CANCEL_PROMPT_LOCATOR}

Verify Search Bar
    Wait Until Element Is Visible    ${SEARCH_BAR_LOCATOR}    timeout=120    error=Search bar did not become visible
    Page Should Contain    DAMON MICHAEL!

Validate Menu Items On Homepage
    [Arguments]    @{menu_items}
    FOR    ${item}    IN    @{menu_items}
        Log    Validating menu item: ${item}
         Wait Until Element Is Visible    //div[text()='${item}']    timeout=120    error=Menu item ${item} did not become visible
        Element Should Be Visible    //div[text()='${item}']
    END



Validate All Menu Items On Homepage
    [Arguments]    @{menu_data}
    FOR    ${menu_item}    IN    @{menu_data}
        ${menu_name}=         Set Variable    ${menu_item["menu_name"]}  # Correctly extract the menu name
        ${expected_heading}=  Set Variable    ${menu_item["expected_heading"]}
        ${expected_url}=      Set Variable    ${menu_item["url"]}

        Log    Validating menu item: ${menu_name}  # Log the menu name for debugging
        Log    Validating menu item heading: ${expected_heading}  # Log the menu name for debugging
        Log    Validating menu item url: ${expected_url}  # Log the menu name for debugging

        # Validate the menu item is visible and clickable
        Wait Until Element Is Visible    //div[text()='${menu_name}']    timeout=30    error=Menu item ${menu_name} did not become visible
        Element Should Be Visible       //div[text()='${menu_name}']
        Click Element                   //div[text()='${menu_name}']
        Sleep    20s

        # Validate Page Heading
        IF    '${expected_heading}' != ''  # Correct string comparison
            Wait Until Element Is Visible    //div[text()='${expected_heading}']    timeout=30    error=Expected heading ${expected_heading} not found for menu item ${menu_name}
            Element Text Should Be    //div[text()='${expected_heading}']    ${expected_heading}
        END

        # Validate URL
        IF    '${expected_url}' != ''  # Correct string comparison
            ${current_url}=    Get Location
            Run Keyword If    "${expected_url}" not in "${current_url}"    Fail    URL validation failed for ${menu_name}. Expected part: ${expected_url}, Found: ${current_url}
        END

        # Go back to the homepage or menu list
        Go Back
    END
