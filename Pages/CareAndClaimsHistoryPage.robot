*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn

*** Variables ***
${CARE_AND_CLAIMS_HISTORY_LOCATOR}    //span[text()='Care & Claims History']
${CARE_AND_CLAIMS_HISTORY_BUTTON_LOCATOR}    //div[@id="feature-list-care-&-claims-history"]
${TOTAL_SPENT_LOCATOR}    //div[text()='TOTAL SPENT IN LAST 12 MONTHS']
${MONTHLY_LOCATOR}    //div[text()='Monthly']
${ACCUMULATOR_YEAR_LOCATOR}    //div[text()='Accumulator Year-to-Date']
${TOTAL_SPENT_ACCUMULATOR_YEAR_LOCATOR}    //div[text()='TOTAL SPENT IN CURRENT ACCUMULATOR YEAR']
${PHARMACY_LOCATOR}    //div[text()='Pharmacy']
${SPENDING_DETAILS_LOCATOR}    //div[text()='SPENDING DETAILS']//following::div[12]
${VISIT_DETAILS_LOCATOR}    //div[text()='Visit Details']
${MEDICAL_LOCATOR}    //div[text()='Medical']
${FAMILY_TAB_LOCATOR}    //div[text()='Family']
${SELF_CHECKBOX_LOCATOR}    //div[text()='Self']//preceding::input[1]

*** Keywords ***

#Click Care And Claims History Menu
#    Sleep    5s
#    Reload Page
#    Wait Until Element Is Visible    ${CARE_AND_CLAIMS_HISTORY_LOCATOR}    timeout=40    error=Care And Claims History button did not become visible
#    Wait Until Element Is Enabled    ${CARE_AND_CLAIMS_HISTORY_LOCATOR}    timeout=40    error=Care And Claims History button is not enabled for interaction
#    Sleep    10s
#    Execute JavaScript    var overlay = document.querySelector('.modal-overlay'); if (overlay) overlay.style.display='none';
#    Execute JavaScript    var element = document.evaluate("${CARE_AND_CLAIMS_HISTORY_BUTTON_LOCATOR}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; if (element) { element.setAttribute('type', 'button'); element.style.border='3px solid red'; element.focus(); element.dispatchEvent(new MouseEvent('click', { bubbles: true, cancelable: true })); }
#    Wait Until Element Is Enabled    ${CARE_AND_CLAIMS_HISTORY_LOCATOR}    timeout=40    error=Care And Claims History button is not enabled for interaction
#    Execute JavaScript    var element = document.evaluate("${CARE_AND_CLAIMS_HISTORY_BUTTON_LOCATOR}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; if (element) { element.focus(); element.dispatchEvent(new KeyboardEvent('keydown', { key: 'Enter', bubbles: true })); element.dispatchEvent(new KeyboardEvent('keyup', { key: 'Enter', bubbles: true })); }
#    Log    Javascript attempted on 'Care And Claims History' button
#    Double Click Element    ${CARE_AND_CLAIMS_HISTORY_BUTTON_LOCATOR}
#    Log    Double Click attempted on 'Care And Claims History' button
#    #Sleep    10s

Click Care And Claims History Menu
    Wait Until Element Is Visible    ${CARE_AND_CLAIMS_HISTORY_LOCATOR}    timeout=30    error=Care And Claims History button did not become visible
    Wait Until Element Is Visible    ${CARE_AND_CLAIMS_HISTORY_BUTTON_LOCATOR}    timeout=30    error=Care And Claims History button did not become visible
    Wait Until Element Is Enabled    ${CARE_AND_CLAIMS_HISTORY_BUTTON_LOCATOR}   timeout=30    error=Element not enabled
    Click Element    ${CARE_AND_CLAIMS_HISTORY_BUTTON_LOCATOR}

Verify Care And Claims History Opened
    [Arguments]    ${CareAndClaimURL}    ${CareAndClaimExpectedText}
    Wait Until Element Is Visible    ${TOTAL_SPENT_LOCATOR}    timeout=40    error=Care And Claims History page not opened
    Page Should Contain    ${CareAndClaimExpectedText}
    ${current_url}=    Get Location
    # Validate if the URL contains the expected string
    Should Contain    ${current_url}    ${CareAndClaimURL}

Change Monthly to Accumulate Year
    [Arguments]    ${expected_textAccumulatorYear}
    Wait Until Element Is Visible    ${MONTHLY_LOCATOR}    timeout=30    error=Accumulate field did not become visible
    Click Element    ${MONTHLY_LOCATOR}
    Wait Until Element Is Visible    ${ACCUMULATOR_YEAR_LOCATOR}    timeout=30    error=Accumulate field did not become visible
    Click Element    ${ACCUMULATOR_YEAR_LOCATOR}
    Wait Until Element Is Visible    ${TOTAL_SPENT_ACCUMULATOR_YEAR_LOCATOR}    timeout=30    error=Accumulate field did not become visible
    Page Should Contain    ${expected_textAccumulatorYear}

Check Uncheck Pharmacy
    Wait Until Element Is Visible    ${PHARMACY_LOCATOR}    timeout=30    error=Pharmacy field did not become visible
    Press Keys    ${PHARMACY_LOCATOR}    [Return]
    Sleep    2s

Click First Spending Details
    Wait Until Element Is Visible    ${SPENDING_DETAILS_LOCATOR}    timeout=30    error=Pharmacy field did not become visible
    Press Keys    ${SPENDING_DETAILS_LOCATOR}    [Return]

Validate Care And Claim Medical Detail Opened
    [Arguments]    ${expected_textCareAndClaimDetailOpened}    ${expected_textCareAndClaimMedicalDetailOpened}
    Wait Until Element Is Visible    ${VISIT_DETAILS_LOCATOR}    timeout=30    error=Accumulate field did not become visible
    Page Should Contain    ${expected_textCareAndClaimDetailOpened}
    Page Should Contain    ${expected_textCareAndClaimMedicalDetailOpened}

Check Uncheck Medical
    Wait Until Element Is Visible    ${MEDICAL_LOCATOR}    timeout=30    error=Pharmacy field did not become visible
    Press Keys    ${MEDICAL_LOCATOR}    [Return]
    Sleep    2s

Validate Care And Claim Pharmacy Detail Opened
    [Arguments]    ${expected_textCareAndClaimDetailOpened}    ${expected_textCareAndClaimPharmacyDetailOpened}
    Wait Until Element Is Visible    ${VISIT_DETAILS_LOCATOR}    timeout=30    error=Accumulate field did not become visible
    Page Should Contain    ${expected_textCareAndClaimDetailOpened}
    Page Should Contain    ${expected_textCareAndClaimPharmacyDetailOpened}

Select and Validate Care And Claim Family tab
    Wait Until Element Is Visible    ${FAMILY_TAB_LOCATOR}    timeout=30    error=Family tab did not become visible
    Press Keys    ${FAMILY_TAB_LOCATOR}    [Return]
    Checkbox Should Be Selected    ${SELF_CHECKBOX_LOCATOR}

Care And Claim Family tab Uncheck Self
    [Arguments]    ${expected_textUncheckSelfNoRecord}
    Wait Until Element Is Visible    ${FAMILY_TAB_LOCATOR}    timeout=30    error=Family tab did not become visible
    Press Keys    ${FAMILY_TAB_LOCATOR}    [Return]
    Click Element    ${SELF_CHECKBOX_LOCATOR}
    Checkbox Should Not Be Selected    ${SELF_CHECKBOX_LOCATOR}
    Page Should Contain    ${expected_textUncheckSelfNoRecord}


Care And Claim Family tab Click
    Wait Until Element Is Visible    ${FAMILY_TAB_LOCATOR}    timeout=30    error=Family tab did not become visible
    Press Keys    ${FAMILY_TAB_LOCATOR}    [Return]