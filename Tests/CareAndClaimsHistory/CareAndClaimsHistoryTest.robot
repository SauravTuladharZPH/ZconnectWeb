*** Settings ***
Library    SeleniumLibrary
Library    ../../Helper/ExcelKeywords.py
Resource    ../../Helper/common.robot
Resource    ../../Pages/LoginPage.robot
Resource    ../../Pages/HomePage.robot
Resource    ../../Pages/CareAndClaimsHistoryPage.robot
Library    RetryFailed    3    5
Test Teardown    Close Browser


*** Test Cases ***
Care And Claims History tests
    Initialize Login Data
    Initialize Care And Claims Data
    Open Login Page     ${URL}
    Enter Group Code    ${GROUP_CODE}
    Agree Terms
    Enter Credentials   ${USERNAME}    ${PASSWORD}
    Click Login
    Skip MFA Setup
    Cancel MFA Prompt
    Verify Search Bar
    Click Care And Claims History Menu
    Verify Care And Claims History Opened    ${CAREANDCLAIMURL}    ${CAREANDCLAIMEXPECTEDTEXT}
    Close Browser

AccumulatorYearToDate Care And Claims History tests
    Initialize Login Data
    Initialize Care And Claims Data
    Open Login Page     ${URL}
    Enter Group Code    ${GROUP_CODE}
    Agree Terms
    Enter Credentials   ${USERNAME}    ${PASSWORD}
    Click Login
    Skip MFA Setup
    Cancel MFA Prompt
    Verify Search Bar
    Click Care And Claims History Menu
    Verify Care And Claims History Opened    ${CAREANDCLAIMURL}    ${CAREANDCLAIMEXPECTEDTEXT}
    Change monthly to Accumulate Year    ${CAREANDCLAIMACCUMULATORYEAREXPECTEDTEXT}
    Close Browser

Medical details validation Care And Claims History tests
    Initialize Login Data
    Initialize Care And Claims Data
    Open Login Page     ${URL}
    Enter Group Code    ${GROUP_CODE}
    Agree Terms
    Enter Credentials   ${USERNAME}    ${PASSWORD}
    Click Login
    Skip MFA Setup
    Cancel MFA Prompt
    Verify Search Bar
    Click Care And Claims History Menu
    Verify Care And Claims History Opened    ${CAREANDCLAIMURL}    ${CAREANDCLAIMEXPECTEDTEXT}
    Check Uncheck Pharmacy
    Click First Spending Details
    Validate Care And Claim Medical Detail Opened    ${CareAndClaimDetailOpenedEXPECTEDTEXT}    ${CareAndClaimMedicalDetailOpenedEXPECTEDTEXT}
    Close Browser

Pharmacy details validation Care And Claims History tests
    Initialize Login Data
    Initialize Care And Claims Data
    Open Login Page     ${URL}
    Enter Group Code    ${GROUP_CODE}
    Agree Terms
    Enter Credentials   ${USERNAME}    ${PASSWORD}
    Click Login
    Skip MFA Setup
    Cancel MFA Prompt
    Verify Search Bar
    Click Care And Claims History Menu
    Verify Care And Claims History Opened    ${CAREANDCLAIMURL}    ${CAREANDCLAIMEXPECTEDTEXT}
    Check Uncheck Medical
    Click First Spending Details
    Validate Care And Claim Pharmacy Detail Opened    ${CareAndClaimDetailOpenedEXPECTEDTEXT}    ${CareAndClaimPharmacyDetailOpenedEXPECTEDTEXT}
    Close Browser

Family tab validation Care And Claims History tests
    Initialize Login Data
    Initialize Care And Claims Data
    Open Login Page     ${URL}
    Enter Group Code    ${GROUP_CODE}
    Agree Terms
    Enter Credentials   ${USERNAME}    ${PASSWORD}
    Click Login
    Skip MFA Setup
    Cancel MFA Prompt
    Verify Search Bar
    Click Care And Claims History Menu
    Verify Care And Claims History Opened    ${CAREANDCLAIMURL}    ${CAREANDCLAIMEXPECTEDTEXT}
    Select and Validate Care And Claim Family tab
    Close Browser

Family tab Self Uncheck Care And Claims History tests
    Initialize Login Data
    Initialize Care And Claims Data
    Open Login Page     ${URL}
    Enter Group Code    ${GROUP_CODE}
    Agree Terms
    Enter Credentials   ${USERNAME}    ${PASSWORD}
    Click Login
    Skip MFA Setup
    Cancel MFA Prompt
    Verify Search Bar
    Click Care And Claims History Menu
    Verify Care And Claims History Opened    ${CAREANDCLAIMURL}    ${CAREANDCLAIMEXPECTEDTEXT}
    Care And Claim Family tab Uncheck Self    ${FamilySelfUncheckEXPECTEDTEXT}
    Close Browser

Family tab Monthly view Care And Claims History tests
    Initialize Login Data
    Initialize Care And Claims Data
    Open Login Page     ${URL}
    Enter Group Code    ${GROUP_CODE}
    Agree Terms
    Enter Credentials   ${USERNAME}    ${PASSWORD}
    Click Login
    Skip MFA Setup
    Cancel MFA Prompt
    Verify Search Bar
    Click Care And Claims History Menu
    Verify Care And Claims History Opened    ${CAREANDCLAIMURL}    ${CAREANDCLAIMEXPECTEDTEXT}
    Care And Claim Family tab Click
    Verify Care And Claims History Opened    ${CAREANDCLAIMURL}    ${CAREANDCLAIMEXPECTEDTEXT}
    Close Browser

Family tab Accumulate Year view Care And Claims History tests
    Initialize Login Data
    Initialize Care And Claims Data
    Open Login Page     ${URL}
    Enter Group Code    ${GROUP_CODE}
    Agree Terms
    Enter Credentials   ${USERNAME}    ${PASSWORD}
    Click Login
    Skip MFA Setup
    Cancel MFA Prompt
    Verify Search Bar
    Click Care And Claims History Menu
    Verify Care And Claims History Opened    ${CAREANDCLAIMURL}    ${CAREANDCLAIMEXPECTEDTEXT}
    Care And Claim Family tab Click
    Change monthly to Accumulate Year    ${CAREANDCLAIMACCUMULATORYEAREXPECTEDTEXT}
    Close Browser

Family tab Medical History Care And Claims History tests
    Initialize Login Data
    Initialize Care And Claims Data
    Open Login Page     ${URL}
    Enter Group Code    ${GROUP_CODE}
    Agree Terms
    Enter Credentials   ${USERNAME}    ${PASSWORD}
    Click Login
    Skip MFA Setup
    Cancel MFA Prompt
    Verify Search Bar
    Click Care And Claims History Menu
    Verify Care And Claims History Opened    ${CAREANDCLAIMURL}    ${CAREANDCLAIMEXPECTEDTEXT}
    Care And Claim Family tab Click
    Check Uncheck Pharmacy
    Click First Spending Details
    Validate Care And Claim Medical Detail Opened    ${CareAndClaimDetailOpenedEXPECTEDTEXT}    ${CareAndClaimMedicalDetailOpenedEXPECTEDTEXT}
    Close Browser

Family tab Pharmacy History Care And Claims History tests
    Initialize Login Data
    Initialize Care And Claims Data
    Open Login Page     ${URL}
    Enter Group Code    ${GROUP_CODE}
    Agree Terms
    Enter Credentials   ${USERNAME}    ${PASSWORD}
    Click Login
    Skip MFA Setup
    Cancel MFA Prompt
    Verify Search Bar
    Click Care And Claims History Menu
    Verify Care And Claims History Opened    ${CAREANDCLAIMURL}    ${CAREANDCLAIMEXPECTEDTEXT}
    Care And Claim Family tab Click
    Check Uncheck Medical
    Click First Spending Details
    Validate Care And Claim Pharmacy Detail Opened    ${CareAndClaimDetailOpenedEXPECTEDTEXT}    ${CareAndClaimPharmacyDetailOpenedEXPECTEDTEXT}
    Close Browser