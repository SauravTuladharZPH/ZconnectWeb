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


#Cost Estimator tests - Search by Provider Category
#    Initialize Login Data
#    Initialize Cost Estimator Data
#    Open Login Page     ${URL}
#    Enter Group Code    ${GROUP_CODE}
#    Agree Terms
#    Enter Credentials   ${USERNAME}    ${PASSWORD}
#    Click Login
#    Skip MFA Setup
#    Cancel MFA Prompt
#    Click Cost Estimator Menu
#    Verify Cost Estimator Opened    ${COSTESTIMATORURL}    ${COSTESTIMATOREXPECTEDTEXT}
#    Verify Browser Session
#    Verify Browser Session Is Active
#    Search by Provider Category
#    Close Browser


#Cost Estimator tests - Search by Procedure
#    Initialize Login Data
#    Initialize Cost Estimator Data
#    Open Login Page     ${URL}
#    Enter Group Code    ${GROUP_CODE}
#    Agree Terms
#    Enter Credentials   ${USERNAME}    ${PASSWORD}
#    Click Login
#    Skip MFA Setup
#    Cancel MFA Prompt
#    Click Cost Estimator Menu
#    Verify Cost Estimator Opened    ${COSTESTIMATORURL}    ${COSTESTIMATOREXPECTEDTEXT}
#    Cost Estimator Search by Procedure
#    Close Browser