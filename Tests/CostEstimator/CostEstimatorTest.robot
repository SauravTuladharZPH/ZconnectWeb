*** Settings ***
Library    SeleniumLibrary
Library    ../../Helper/ExcelKeywords.py
Resource    ../../Helper/common.robot
Resource    ../../Pages/LoginPage.robot
Resource    ../../Pages/HomePage.robot
Resource    ../../Pages/CostEstimatorPage.robot
Test Teardown    Close Browser

*** Test Cases ***
Cost Estimator tests
    Initialize Login Data
    Initialize Cost Estimator Data
    Open Login Page     ${URL}
    Enter Group Code    ${GROUP_CODE}
    Agree Terms
    Enter Credentials   ${USERNAME}    ${PASSWORD}
    Click Login
    Skip MFA Setup
    Cancel MFA Prompt
    Click Cost Estimator Menu
    Verify Cost Estimator Opened    ${COSTESTIMATORURL}    ${COSTESTIMATOREXPECTEDTEXT}
    Close Browser
    #Type In Chat


Cost Estimator tests - Search by Provider Category
    Initialize Login Data
    Initialize Cost Estimator Data
    Open Login Page     ${URL}
    Set Geolocation    42.37954    -71.24642    10.0
    Enter Group Code    ${GROUP_CODE}
    Agree Terms
    Enter Credentials   ${USERNAME}    ${PASSWORD}
    Click Login
    Skip MFA Setup
    Cancel MFA Prompt
    Click Cost Estimator Menu
    Verify Cost Estimator Opened    ${COSTESTIMATORURL}    ${COSTESTIMATOREXPECTEDTEXT}
    Search by Provider Category


Cost Estimator - Validate Speciality Under Provider Category
    Initialize Login Data
    Initialize Cost Estimator Data
    Open Login Page     ${URL}
    Enter Group Code    ${GROUP_CODE}
    Agree Terms
    Enter Credentials   ${USERNAME}    ${PASSWORD}
    Click Login
    Skip MFA Setup
    Cancel MFA Prompt
    Click Cost Estimator Menu
    Verify Cost Estimator Opened    ${COSTESTIMATORURL}    ${COSTESTIMATOREXPECTEDTEXT}
    ${data}=    Read Cost Estimator Provider Category and Specialities
    Validate Speciality Under Provider Category    ${data}


Cost Estimator tests - Search by Procedure
    ${skip}=    Set Variable    True
    Run Keyword If    ${skip}    Skip    Skipping Test Case
    Initialize Login Data
    Initialize Cost Estimator Data
    Open Login Page     ${URL}
    Set Geolocation    42.37954    -71.24642    10.0
    Enter Group Code    ${GROUP_CODE}
    Agree Terms
    Enter Credentials   ${USERNAME}    ${PASSWORD}
    Click Login
    Skip MFA Setup
    Cancel MFA Prompt
    Click Cost Estimator Menu
    Verify Cost Estimator Opened    ${COSTESTIMATORURL}    ${COSTESTIMATOREXPECTEDTEXT}
    Cost Estimator Search by Procedure
    Close Browser


Cost Estimator tests - Search by All available Provider Category
    Initialize Login Data
    Initialize Cost Estimator Data
    Open Login Page     ${URL}
    Set Geolocation    42.37954    -71.24642    10.0
    Enter Group Code    ${GROUP_CODE}
    Agree Terms
    Enter Credentials   ${USERNAME}    ${PASSWORD}
    Click Login
    Skip MFA Setup
    Cancel MFA Prompt
    Click Cost Estimator Menu
    Verify Cost Estimator Opened    ${COSTESTIMATORURL}    ${COSTESTIMATOREXPECTEDTEXT}
    ${data}=    Read Cost Estimator Provider Category and Specialities
    Validate Search by All available Provider Category    ${data}


Cost Estimator tests - Advance Search
    Initialize Login Data
    Initialize Cost Estimator Data
    Open Login Page     ${URL}
    Set Geolocation    42.37954    -71.24642    10.0
    Enter Group Code    ${GROUP_CODE}
    Agree Terms
    Enter Credentials   ${USERNAME}    ${PASSWORD}
    Click Login
    Skip MFA Setup
    Cancel MFA Prompt
    Click Cost Estimator Menu
    Verify Cost Estimator Opened    ${COSTESTIMATORURL}    ${COSTESTIMATOREXPECTEDTEXT}
    ${data}=    Read Cost Estimator Provider Category and Specialities
    Validate Search Using Advance Search    ${data}