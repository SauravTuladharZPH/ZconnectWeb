*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn
Library    RetryFailed    3    5
Library    ../Helper/ExcelKeywords.py
Library    Collections
Library    String

*** Variables ***
${COST_ESTIMATOR_FEATURE_LIST}   //div[@id="feature-list-cost-estimator"]
${COST_ESTIMATOR_PAGE_TEXT}   //div[text()='Need a cost estimate for one of your enrolled dependents?']
${COST_ESTIMATOR_X_BUTTON}   //div[text()='X']
${PROCEDURE_SELECTOR}   (//div[contains(text(), 'Select a Procedure')]//following::div[contains(., '(') and contains(., ')')])[8]
${SEARCH_BUTTON}   //div[text()='Search']
${SHOW_LOCATION_IN_MAP}   //div[text()='Show location in map']
${ADVANCED_SEARCH_BUTTON}   //div[contains(text(), 'Advanced Search')]
${DISTANCE_SELECT}   //option[contains(text(), 'Select a Distance')]//parent::select
${MILES_RESULT}   //div[contains(text(), 'Cost Estimator Results')]//following::div[13]
${SELECTED_SPECIALITY_RESULT}   //div[contains(text(), 'Cost Estimator Results')]//following::div[20]
${SELECTED_PROCEDURE_RESULT}   //div[contains(text(), 'Cost Estimator Results')]//following::div[23]
${LOCATION_TEXTAREA_INPUT}    //textarea[@placeholder="Select a Location"]
${SELECT_BOSTON_LOCATION}    //div[text()='Boston, MA, USA']
${ACUPUNCTURE_LOCATOR}    //span[text()='ACUPUNCTURE']
${ACUPUNCTURE_SELECT_LOCATOR}    //div[text()='ACUPUNCTURE']
${SINGLE_VITAMIN_NOS_LOCATOR}    //div[text()='SINGLE VITAMIN NOS']
${ACUPUNCTURE_TEXTAREA_LOCATOR}    //textarea[text()='ACUPUNCTURE']
${SINGLE_VITAMIN_NOS_TEXTAREA_LOCATOR}    //textarea[text()='SINGLE VITAMIN NOS']
${SEARCH_INPUT_LOCATOR}      //input[@placeholder="E.g. X-ray or Hospital"]
${SEARCH_RESULT_LOCATOR}     //div[text()='Single Vitamin Nos']
${SEARCH_RESULT_PARENT_LOCATOR}    (//div[text()='Single Vitamin Nos']//parent::div)[1]


*** Keywords ***

Click Cost Estimator Menu
    Wait Until Element Is Visible    ${COST_ESTIMATOR_FEATURE_LIST}    timeout=40    error=Cost Estimator button did not become visible
    Wait Until Element Is Enabled    ${COST_ESTIMATOR_FEATURE_LIST}    timeout=40    error=Cost Estimator button is not enabled for interaction
    Click Element    ${COST_ESTIMATOR_FEATURE_LIST}


Verify Cost Estimator Opened
    [Arguments]    ${CostEstimatorURL}    ${CostEstimatorExpectedText}
    Wait Until Element Is Visible    ${COST_ESTIMATOR_PAGE_TEXT}    timeout=40    error=Cost estimator page not opened
    Page Should Contain    ${CostEstimatorExpectedText}
    ${current_url}=    Get Location
    Should Contain    ${current_url}    ${CostEstimatorURL}
    Wait Until Element Is Visible    ${COST_ESTIMATOR_X_BUTTON}    timeout=40    error=X not clicked
    Click Element    ${COST_ESTIMATOR_X_BUTTON}


Search by Provider Category
    Wait Until Element Is Visible    ${ACUPUNCTURE_LOCATOR}    timeout=40    error=Acupunture selectbox not visible
    Click Element    ${ACUPUNCTURE_LOCATOR}
    Wait Until Element Is Visible    ${ACUPUNCTURE_SELECT_LOCATOR}    timeout=40    error=Acupunture selectbox not visible
    Click Element    ${ACUPUNCTURE_SELECT_LOCATOR}
    Wait Until Element Is Visible    ${SINGLE_VITAMIN_NOS_LOCATOR}    timeout=40    error=Provider not visible
    Click Element    ${SINGLE_VITAMIN_NOS_LOCATOR}
    Wait Until Element Is Visible    ${ACUPUNCTURE_TEXTAREA_LOCATOR}    timeout=40    error=Validate Selected provider failed
    Element Should Contain    ${ACUPUNCTURE_TEXTAREA_LOCATOR}    ACUPUNCTURE
    Wait Until Element Is Visible    ${SINGLE_VITAMIN_NOS_TEXTAREA_LOCATOR}    timeout=40    error=Validate Selected procedure failed
    Element Should Contain    ${SINGLE_VITAMIN_NOS_TEXTAREA_LOCATOR}    SINGLE VITAMIN NOS
    Wait Until Element Is Visible    ${SEARCH_BUTTON}    timeout=40    error=Search not visible
    Click Element    ${SEARCH_BUTTON}
    Wait Until Element Is Visible    ${SHOW_LOCATION_IN_MAP}    timeout=30    error=Show location in map not displayed
    Page Should Contain    Show location in map
    ${current_url}=    Get Location
    Should Contain    ${current_url}    /provider-search-pt-result


Cost Estimator Search by Procedure
    #[Arguments]    ${CostEstimatorURL}    ${CostEstimatorExpectedText}
    Wait Until Element Is Visible    ${SEARCH_INPUT_LOCATOR}    timeout=40    error=Cost estimator page search not found
    Wait Until Element Is Enabled    ${SEARCH_INPUT_LOCATOR}    timeout=40    error=Cost estimator page search not found
    Sleep    5s
    Input Text    ${SEARCH_INPUT_LOCATOR}    SINGLE VITAMIN NOS
    Sleep    5s
    Wait Until Element Is Visible    ${SEARCH_RESULT_LOCATOR}    timeout=30    error=Search field did not become visible
    Wait Until Element Is Enabled    ${SEARCH_RESULT_LOCATOR}    timeout=30    error=Search field did not become visible
    Click Element    ${SEARCH_RESULT_PARENT_LOCATOR}
    Wait Until Element Is Visible    ${SHOW_LOCATION_IN_MAP}    timeout=30    error=Search did not become visible
    Page Should Contain    ${SHOW_LOCATION_IN_MAP}
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
            # Click on the procedure under the selected specialty
            Wait Until Element Is Visible    ${PROCEDURE_SELECTOR}
            Click Element    ${PROCEDURE_SELECTOR}
            Click Element    //div[text()='Search']
            # Verify the map becomes visible
            Wait Until Element Is Visible    ${SHOW_LOCATION_IN_MAP}    timeout=30    error=Map did not become visible
            Page Should Contain    Show location in map
            # Navigate back to the list page to select the next specialty
            Go Back
        END
    END


Validate Search Using Advance Search
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
            # Click on the procedure under the selected specialty
            Wait Until Element Is Visible    ${PROCEDURE_SELECTOR}
            ${procedure}=    Get Text    ${PROCEDURE_SELECTOR}
            Click Element    ${PROCEDURE_SELECTOR}
            Click Element    ${ADVANCED_SEARCH_BUTTON}
            Input Text    ${LOCATION_TEXTAREA_INPUT}    Boston, MA, USA
            Wait Until Element Is Visible    ${SELECT_BOSTON_LOCATION}
            Click Element    ${SELECT_BOSTON_LOCATION}
            Sleep    2s
            Select From List By Value    ${DISTANCE_SELECT}    20
            Click Element    ${SEARCH_BUTTON}
            # Verify the map becomes visible
            Wait Until Element Is Visible    ${SHOW_LOCATION_IN_MAP}    timeout=30    error=Map did not become visible
            Page Should Contain    Show location in map
            ${selected_location}=    Get Text    ${LOCATION_TEXTAREA_INPUT}
            ${miles}=    Get Text    ${MILES_RESULT}
            ${selected_speciality}=    Get Text    ${SELECTED_SPECIALITY_RESULT}
            ${selected_procedure}=    Get Text    ${SELECTED_PROCEDURE_RESULT}
            ${clean_selected_procedure_text}=    Strip String    ${selected_procedure}
            Should Contain    ${selected_speciality}    ${speciality_str}
            Should Contain    ${procedure}    ${clean_selected_procedure_text}
            Should Contain    ${miles}    20
            Should Contain    ${selected_location}    Boston, MA, USA
            # Navigate back to the list page to select the next specialty
            Go Back
        END
    END