*** Settings ***
Library    SeleniumLibrary
Library    ../Helper/ExcelKeywords.py
Resource    ../Helper/common.robot
Library    BuiltIn

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
    Wait Until Element Is Enabled    //div[@id="menu_icon"]    timeout=30    error=SideBar did not become enabled
    Click Element    //div[@id="menu_icon"]

Click Submenu
    [Arguments]    ${submenu}
    Execute JavaScript    var element = document.evaluate("//div[contains(@class, 'css-901oao') and contains(text(), '${submenu}')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; if (element) { element.setAttribute('type', 'button'); element.setAttribute('id', 'sideBarSubMenu'); element.style.border='3px solid red'; element.dispatchEvent(new MouseEvent('click', { bubbles: true, cancelable: true })); }
    Click Element    //div[contains(@class, 'css-901oao') and contains(text(), '${submenu}')]
    Click Element    //div[@id="sideBarSubMenu"]
    Sleep    3s


Validate Page Heading And URL
    [Arguments]    ${menu_name}    ${expected_heading}    ${expected_url}
    ${actual_heading}=    Get Text    (//div[contains(@class, 'css-901oao')])[1]  # Assuming heading is in an <h1> tag
    Should Be Equal    ${actual_heading}    ${expected_heading}    Heading for ${menu_name} is incorrect.

    ${current_url}=    Get Location
    Should End With    ${current_url}    ${expected_url}    URL for ${menu_name} is incorrect.

Validate Sidebar Menu Items
    [Arguments]    ${main_menu}    ${menu_data}
    ${submenus}=    Get From Dictionary    ${menu_data}    submenus
    ${heading}=     Get From Dictionary    ${menu_data}    heading
    ${url}=         Get From Dictionary    ${menu_data}    url

    # Log the submenus for debugging
    Log    Submenus content: ${submenus}

    # Click the main menu
    Log    Validating main menu: ${main_menu}
    Execute JavaScript    var element = document.evaluate("//div[contains(@class, 'css-901oao') and contains(text(), '${main_menu}')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; if (element) { element.setAttribute('type', 'button'); element.setAttribute('id', 'sideBarMenu'); element.style.border='3px solid red'; element.dispatchEvent(new MouseEvent('click', { bubbles: true, cancelable: true })); }
    Click Element    //div[contains(@class, 'css-901oao') and contains(text(), '${main_menu}')]
    Click Element    //div[@id="sideBarMenu"]
    Sleep    3s

    # Handle special cases for submenus
    Run Keyword If    ${submenus} and ('Privacy Policy' in ${submenus} or 'Terms & Condition' in ${submenus} or 'SBC Document' in ${submenus} or 'EOB' in ${submenus})    Handle New Tab    ${submenus}

    # Exclude special cases from further submenu validation
    ${filtered_submenus}=    Evaluate    [item for item in ${submenus} if item not in ['Privacy Policy', 'Terms & Condition', 'SBC Document', 'EOB']]

    # Log the filtered submenus for debugging
    Log    Filtered Submenus: ${filtered_submenus}

    # Validate remaining submenus, including Services Contact Info
    Run Keyword If    ${filtered_submenus} != []    Submenus Found    ${main_menu}    ${filtered_submenus}    ${heading}    ${url}

    # If no submenus, validate directly
    Run Keyword If    ${submenus} == None    Validate Page Heading And URL    ${main_menu}    ${heading}    ${url}

    Go Back
    Sleep    3s
    Click SideBar
    Sleep    3s


Handle New Tab
    [Arguments]    ${submenus}
    FOR    ${submenu}    IN    @{submenus}
        Run Keyword If    '${submenu}' in ['Privacy Policy', 'Terms & Condition', 'SBC Document', 'EOB']    Click Submenu    ${submenu}
    END

    Sleep    5s

    # Get all window handles
    ${windows}=    Get Window Handles
    ${window_count}=    Get Length    ${windows}

    # Ensure there are exactly 2 windows (the original and the new tab)
    Should Be Equal As Numbers    ${window_count}    2

    # Switch to the new tab (assuming the new tab is at index 1)
    Switch Window    ${windows[1]}
    Sleep    3s

    # Close the new tab
    Close Window
    Sleep    3s
    # Switch back to the original tab
    Switch Window    ${windows[0]}
    Sleep    3s

Submenus Found
    [Arguments]    ${main_menu}    ${submenus}    ${heading}    ${url}
    Log    Submenus found for ${main_menu}: ${submenus}

    # Ensure that heading and url are treated as strings
    ${heading}=    Set Variable    ${heading}
    ${url}=        Set Variable    ${url}

    # Initialize empty lists for headings and URLs
    ${headings_list}=    Create List
    ${urls_list}=        Create List

    # Check if the heading contains a comma and split it
    ${heading_contains_comma}=    Run Keyword And Return Status    ',' in ${heading}
    Run Keyword If    ${heading_contains_comma}    Append To List    ${headings_list}    ${heading.split(',')}
    Run Keyword If    ${heading_contains_comma} == False    Append To List    ${headings_list}    ${heading}

    # Check if the URL contains a comma and split it
    ${url_contains_comma}=    Run Keyword And Return Status    ',' in ${url}
    Run Keyword If    ${url_contains_comma}    Append To List    ${urls_list}    ${url.split(',')}
    Run Keyword If    ${url_contains_comma} == False    Append To List    ${urls_list}    ${url}

    # Log the populated lists to debug
    Log    Headings List: ${headings_list}
    Log    URLs List: ${urls_list}

    # Check if the submenus list is longer than the other lists
    ${num_submenus}=    Get Length    ${submenus}
    ${num_headings}=    Get Length    ${headings_list}
    ${num_urls}=        Get Length    ${urls_list}

    # Ensure headings and URLs lists match the number of submenus
    Run Keyword If    ${num_headings} < ${num_submenus}    Append To List    ${headings_list}    ${heading}    # Padding headings list if needed
    Run Keyword If    ${num_urls} < ${num_submenus}    Append To List    ${urls_list}    ${url}    # Padding URLs list if needed

    # Log the adjusted lists
    Log    Adjusted Headings List: ${headings_list}
    Log    Adjusted URLs List: ${urls_list}

    # Iterate through submenus
    FOR    ${index}    IN RANGE    0    ${submenus.__len__()}
        ${submenu}=    Get From List    ${submenus}    ${index}
        ${expected_headings}=    Get From List    ${headings_list}    ${index}
        ${expected_url}=    Get From List    ${urls_list}    ${index}

        Log    Validating submenu: ${submenu}

        # Clean up expected headings by splitting by comma and stripping whitespace using Evaluate
        ${expected_headings_list}=    Create List
        FOR    ${expected_heading}    IN    @{expected_headings.split(',')}
            ${cleaned_heading}=    Evaluate    '${expected_heading.strip()}'
            Append To List    ${expected_headings_list}    ${cleaned_heading}
        END

        ${expected_urls_list}=    Create List
        FOR    ${expected_url}    IN    @{expected_url.split(',')}
            ${cleaned_url}=    Evaluate    '${expected_url.strip()}'
            Append To List    ${expected_urls_list}    ${cleaned_url}
        END

        # Click the submenu and validate the page heading and URL
        Click Submenu    ${submenu}
        Validate Page Heading And URL    ${submenu}    ${expected_headings_list[${index}]}    ${expected_urls_list[${index}]}

        # Navigate back to the sidebar and click the main menu for subsequent iterations
        Run Keyword If    ${index} < ${submenus.__len__() - 1}
        ...    Go Back And Reopen Menu    ${main_menu}
    END


Go Back And Reopen Menu
    [Arguments]    ${main_menu}
    Log    Navigating back to main menu: ${main_menu}
    Go Back
    Sleep    2s
    Click SideBar
    Sleep    2s
    Log    Clicking main menu: ${main_menu}
    Execute JavaScript    var element = document.evaluate("//div[contains(@class, 'css-901oao') and contains(text(), '${main_menu}')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; if (element) { element.setAttribute('type', 'button'); element.setAttribute('id', 'sideBarMenu'); element.style.border='3px solid red'; element.dispatchEvent(new MouseEvent('click', { bubbles: true, cancelable: true })); }
    Click Element    //div[contains(@class, 'css-901oao') and contains(text(), '${main_menu}')]
    Click Element    //div[@id="sideBarMenu"]
    Sleep    3s