*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn
#Library    RetryFailed    3    5
Library    ../Helper/ExcelKeywords.py
Library    Collections
Library    String


*** Keywords ***
#Click Cost Estimator Menu
#    Sleep    5s
#    Reload Page
#    Wait Until Element Is Visible    //div[text()='Cost Estimator']    timeout=40    error=Cost Estimator button did not become visible
#    Wait Until Element Is Enabled    //div[text()='Cost Estimator']    timeout=40    error=Cost Estimator button is not enabled for interaction
#    Sleep    10s
#    Execute JavaScript    var overlay = document.querySelector('.modal-overlay'); if (overlay) overlay.style.display='none';
#    Execute JavaScript    var element = document.evaluate("//div[text()='Cost Estimator']//ancestor::div[2][@role='button']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; if (element) { element.setAttribute('type', 'button'); element.style.border='3px solid red'; element.dispatchEvent(new MouseEvent('click', { bubbles: true, cancelable: true })); }
#    Wait Until Element Is Enabled    //div[text()='Cost Estimator']    timeout=40    error=Cost Estimator button did not become visible
#    Execute JavaScript    var element = document.evaluate("//div[text()='Cost Estimator']//ancestor::div[2][@role='button']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; if (element) { element.focus(); element.dispatchEvent(new KeyboardEvent('keydown', { key: 'Enter', bubbles: true })); element.dispatchEvent(new KeyboardEvent('keyup', { key: 'Enter', bubbles: true })); }
#    BuiltIn.Log    Javascript attempted on 'Cost Estimator' button
#    Double Click Element    //div[text()='Cost Estimator']//ancestor::div[2][@role='button']
#    BuiltIn.Log    Double Click attempted on 'Cost Estimator' button
#    Sleep    5s

Click Cost Estimator Menu

    Wait Until Element Is Visible    //div[@id="cost-estimator-feature-list"]    timeout=40    error=Cost Estimator button did not become visible
    Wait Until Element Is Enabled    //div[@id="cost-estimator-feature-list"]    timeout=40    error=Cost Estimator button is not enabled for interaction
    Click Element    //div[@id="cost-estimator-feature-list"]



Verify Cost Estimator Opened
    [Arguments]    ${CostEstimatorURL}    ${CostEstimatorExpectedText}
    Wait Until Element Is Visible    //div[text()='Need a cost estimate for one of your enrolled dependents?']    timeout=40    error=Cost estimator page not opened
    Page Should Contain    ${CostEstimatorExpectedText}

    ${current_url}=    Get Location
    Should Contain    ${current_url}    ${CostEstimatorURL}

    Wait Until Element Is Visible    //div[text()='X']    timeout=40    error=X not clicked
    Click Element    //div[text()='X']


#Search by Provider Category
#
#
#    Wait Until Element Is Enabled    //span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']    timeout=40    error=Cost Estimator button did not become visible
#
#    Execute JavaScript    var element = document.evaluate("//span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; if (element) { element.focus(); element.dispatchEvent(new KeyboardEvent('keydown', { key: 'Enter', bubbles: true })); element.dispatchEvent(new KeyboardEvent('keyup', { key: 'Enter', bubbles: true })); }
#    Log    Javascript attempted on 'Cost Estimator' button
#
#    Double Click Element    //span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']
#    Log    Double Click attempted on 'Cost Estimator' button
#    Press Keys    //span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']    [TAB]
#    Press Keys       //span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']    [ENTER]
#
#
#    Wait Until Page Contains Element    //span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']    timeout=30
#    Wait Until Element Is Enabled    //span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']    timeout=40    error=Acupunture button did not become visible
#    Verify Browser Session Is Active
#    Custom.Click Element With Actions    //span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']
#
#
#    Wait Until Element Is Visible    //div[text()='ACUPUNCTURE']    timeout=40    error=Acupunture selectbox not visible
#    Click Element    //div[text()='ACUPUNCTURE']
#
#    Wait Until Element Is Visible    //div[text()='SINGLE VITAMIN NOS']    timeout=40    error=Provider not visible
#    Click Element    //div[text()='SINGLE VITAMIN NOS']
#
#    Wait Until Element Is Visible    //textarea[text()='ACUPUNCTURE']    timeout=40    error=Validate Selected provider failed
#    Element Should Contain    //textarea[text()='ACUPUNCTURE']    ACUPUNCTURE
#
#    Wait Until Element Is Visible    //textarea[text()='SINGLE VITAMIN NOS']    timeout=40    error=Validate Selected procedure failed
#    Element Should Contain    //textarea[text()='SINGLE VITAMIN NOS']    SINGLE VITAMIN NOS
#
#    Wait Until Element Is Visible    //div[text()='Search']    timeout=40    error=Search not visible
#    Click Element    //div[text()='Search']
#
#
#    ${current_url}=    Get Location
#    Should Contain    ${current_url}    /provider-search-pt-result


Search by Provider Category
    Wait Until Element Is Visible    //span[text()='ACUPUNCTURE']    timeout=40    error=Acupunture selectbox not visible
    Click Element    //span[text()='ACUPUNCTURE']
    Wait Until Element Is Visible    //div[text()='ACUPUNCTURE']    timeout=40    error=Acupunture selectbox not visible
    Click Element    //div[text()='ACUPUNCTURE']
    Wait Until Element Is Visible    //div[text()='SINGLE VITAMIN NOS']    timeout=40    error=Provider not visible
    Click Element    //div[text()='SINGLE VITAMIN NOS']
    Wait Until Element Is Visible    //textarea[text()='ACUPUNCTURE']    timeout=40    error=Validate Selected provider failed
    Element Should Contain    //textarea[text()='ACUPUNCTURE']    ACUPUNCTURE
    Wait Until Element Is Visible    //textarea[text()='SINGLE VITAMIN NOS']    timeout=40    error=Validate Selected procedure failed
    Element Should Contain    //textarea[text()='SINGLE VITAMIN NOS']    SINGLE VITAMIN NOS
    Wait Until Element Is Visible    //div[text()='Search']    timeout=40    error=Search not visible
    Click Element    //div[text()='Search']
    Wait Until Element Is Visible    //div[text()='Show location in map']    timeout=30    error=Show location in map not displayed
    Page Should Contain    Show location in map
    ${current_url}=    Get Location
    Should Contain    ${current_url}    /provider-search-pt-result


Cost Estimator Search by Procedure
    #[Arguments]    ${CostEstimatorURL}    ${CostEstimatorExpectedText}
    Wait Until Element Is Visible    //input[@placeholder="E.g. X-ray or Hospital"]    timeout=40    error=Cost estimator page search not found
    Wait Until Element Is Enabled    //input[@placeholder="E.g. X-ray or Hospital"]    timeout=40    error=Cost estimator page search not found
    Sleep    5s
    Input Text    //input[@placeholder="E.g. X-ray or Hospital"]    SINGLE VITAMIN NOS
    Sleep    5s
    Wait Until Element Is Visible    //div[text()='Single Vitamin Nos']    timeout=30    error=Search field did not become visible
    Wait Until Element Is Enabled    //div[text()='Single Vitamin Nos']    timeout=30    error=Search field did not become visible
    Click Element    (//div[text()='Single Vitamin Nos']//parent::div)[1]
    Wait Until Element Is Visible    //div[text()='Show location in map']    timeout=30    error=Search did not become visible
    Page Should Contain    Show location in map
    ${current_url}=    Get Location
    Should Contain    ${current_url}    /provider-search-pt-result


Validate Speciality Under Provider Category
    [Arguments]    ${data}
    FOR    ${category}    ${specialities}    IN    &{data}
        Log    Validating category: ${category} with specialities: ${specialities}
        # Wait for and click the provider category
        Wait Until Element Is Visible    //span[text()='${category}']    timeout=30    error=Category ${category} not visible
        Click Element    //span[text()='${category}']
        # Check if ${specialities} is a string and split it into a list if necessary
        ${specialities_list}=    Evaluate    ${specialities} if isinstance(${specialities}, list) else ${specialities}.split(',')
        Log    Specialities list: ${specialities_list}
        # Validate all specialities are visible
        FOR    ${speciality}    IN    @{specialities_list}
            ${speciality_str}=    Strip String    ${speciality}
            Log    Validating speciality: ${speciality_str}
            # Wait for and validate the specialty is visible on the page
            Wait Until Element Is Visible    //div[text()='${speciality_str}']    timeout=40    error=Speciality ${speciality_str} not visible
            Element Should Be Visible    //div[text()='${speciality_str}']
        END
        Click Element    //div[text()='X']
    END


Type In Chat
    Wait Until Element Is Visible    //input[@placeholder='How can we help?']    timeout=40    error=Cost Estimator button did not become visible
    Input Text    //input[@placeholder='How can we help?']    Hello


Validate Search by All Available Provider Category
    [Arguments]    ${data}
    FOR    ${category}    ${specialities}    IN    &{data}
        Log    Validating category: ${category} with specialities: ${specialities}

        # Check if ${specialities} is a string and split it into a list if necessary
        ${specialities_list}=    Evaluate    ${specialities} if isinstance(${specialities}, list) else ${specialities}.split(',')
        Log    Specialities list: ${specialities_list}

        # Validate all specialties are visible
        FOR    ${speciality}    IN    @{specialities_list}
            ${speciality_str}=    Strip String    ${speciality}
            Log    Validating speciality: ${speciality_str}

            # Re-select the category after navigating back to the list page
            Wait Until Element Is Visible    //span[text()='${category}']    timeout=30    error=Category ${category} not visible
            Click Element    //span[text()='${category}']

            # Wait for and validate the specialty is visible on the page
            Wait Until Element Is Visible    //div[text()='${speciality_str}']    timeout=40    error=Speciality ${speciality_str} not visible
            Element Should Be Visible    //div[text()='${speciality_str}']
            Click Element    //div[text()='${speciality_str}']
#            Sleep    3s

            # Click on the procedure under the selected specialty
            Wait Until Element Is Visible    (//div[contains(text(), 'Select a Procedure')])[2]//following::div[contains(., '(') and contains(., ')')][3]
            Click Element    (//div[contains(text(), 'Select a Procedure')])[2]//following::div[contains(., '(') and contains(., ')')][3]
            Click Element    //div[text()='Search']

            # Verify the map becomes visible
            Wait Until Element Is Visible    //div[text()='Show location in map']    timeout=30    error=Map did not become visible
            Page Should Contain    Show location in map

            # Navigate back to the list page to select the next specialty
            Go Back
        END
    END