*** Settings ***
Library    SeleniumLibrary
Library    /Users/saurav.tuladhar/Automation/RobotProject/Helper/ExcelKeywords.py
Resource   /Users/saurav.tuladhar/Automation/RobotProject/Helper/common.robot
Resource   /Users/saurav.tuladhar/Automation/RobotProject/Pages/LoginPage.robot
Resource   /Users/saurav.tuladhar/Automation/RobotProject/Pages/HomePage.robot

*** Variables ***
${Empty_Value}

*** Test Cases ***
Login and Verify Dashboard is visible
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
    Close Browser

Empty Group code login test
    Initialize Login Data
    Initialize Care And Claims Data
    Open Login Page     ${URL}
    Enter Group Code    ${Empty_Value}
    Validate Group Code Error Message    ${EMPTYGROUPCODEERROR}
    Close Browser

Invalid Group Code login test
    Initialize Login Data
    Initialize Care And Claims Data
    Open Login Page     ${URL}
    Enter Group Code    ${INVALIDGROUPCODE}
    Validate Group Code Error Message    ${INVALIDGROUPCODEERROR}
    Close Browser

Invalid Username and valid password login test
    Initialize Login Data
    Initialize Care And Claims Data
    Open Login Page     ${URL}
    Enter Group Code    ${GROUP_CODE}
    Agree Terms
    Enter Credentials   ${INVALIDUSERNAME}    ${PASSWORD}
    Click Login
    Validate Login page Error Message    ${NOUSERERROR}
    Close Browser

Valid Username and Invalid password login test
    Initialize Login Data
    Initialize Care And Claims Data
    Open Login Page     ${URL}
    Enter Group Code    ${GROUP_CODE}
    Agree Terms
    Enter Credentials   ${USERNAME}    ${INVALIDPASSWORD}
    Click Login
    Validate Login page Error Message    ${INVALIDCREDENTIALSERROR}
    Close Browser

Invalid Username and Invalid password login test
    Initialize Login Data
    Initialize Care And Claims Data
    Open Login Page     ${URL}
    Enter Group Code    ${GROUP_CODE}
    Agree Terms
    Enter Credentials   ${INVALIDUSERNAME}    ${INVALIDPASSWORD}
    Click Login
    Validate Login page Error Message    ${NOUSERERROR}
    Close Browser

Empty Username and valid password login test
    Initialize Login Data
    Initialize Care And Claims Data
    Open Login Page     ${URL}
    Enter Group Code    ${GROUP_CODE}
    Agree Terms
    Enter Credentials   ${Empty_Value}    ${PASSWORD}
    Click Login
    Validate Login page Error Message    ${EMPTYUSERNAMEERROR}
    Close Browser

Valid Username and Empty password login test
    Initialize Login Data
    Initialize Care And Claims Data
    Open Login Page     ${URL}
    Enter Group Code    ${GROUP_CODE}
    Agree Terms
    Enter Credentials   ${USERNAME}    ${Empty_Value}
    Click Login
    Validate Login page Error Message    ${EMPTYPASSWORDERROR}
    Close Browser

Empty Username and Empty password login test
    Initialize Login Data
    Initialize Care And Claims Data
    Open Login Page     ${URL}
    Enter Group Code    ${GROUP_CODE}
    Agree Terms
    Enter Credentials   ${Empty_Value}    ${Empty_Value}
    Click Login
    Validate Login page Error Message    ${EMPTYUSERNAMEANDPASSWORDERROR}
    Close Browser

Forget Password Invalid User Test
    Initialize Login Data
    Open Login Page     ${URL}
    Enter Group Code    ${GROUP_CODE}
    Agree Terms
    Click Forget Password
    Forget Password Invalid User    ${INVALIDUSERNAME}    ${FORGOTUSERNOTEXISTS}
    Close Browser

Forget Password Valid User Test
    Initialize Login Data
    Open Login Page     ${URL}
    Enter Group Code    ${GROUP_CODE}
    Agree Terms
    Click Forget Password
    Forget Password    ${FORGETUSER}    ${NEWPASSWORD}    ${CONFIRMNEWPASSWORD}    ${PASSWORDCHANGEDMESSAGE}
    Close Browser

Forget Username Valid User Test
    Initialize Login Data
    Open Login Page     ${URL}
    Enter Group Code    ${GROUP_CODE}
    Agree Terms
    Click Forget Password
    Click Forget Username    ${FORGOTEMAIL}    ${FORGOTEMAILSUCCESSMESSAGE}
    Close Browser



Login Page Help Test
    Initialize Login Data
    Open Login Page     ${URL}
    Enter Group Code    ${GROUP_CODE}
    Agree Terms
    Login Help
    Close Browser

Help Change Group Test
    Initialize Login Data
    Open Login Page     ${URL}
    Enter Group Code    ${GROUP_CODE}
    Agree Terms
    Help Clicking on Change navigates to Group page
    Close Browser


Login Page Locate Information
    Initialize Login Data
    Open Login Page     ${URL}
    Locate Information Test
    Close Browser