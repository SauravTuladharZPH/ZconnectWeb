*** Settings ***
Library    SeleniumLibrary
Resource   /Users/saurav.tuladhar/Automation/RobotProject/Helper/common.robot
Resource   /Users/saurav.tuladhar/Automation/RobotProject/Pages/LoginPage.robot


*** Variables ***
${LOGIN_USERNAME_INPUT}         //input[@placeholder="Enter your username"]
${PASSWORD_INPUT}               //input[@placeholder="Password"]
${CONFIRM_PASSWORD_INPUT}       //input[@placeholder="Confirm password"]
${FIRST_NAME_INPUT}             //input[@placeholder="First Name"]
${LAST_NAME_INPUT}              //input[@placeholder="Last Name"]
${DOB_INPUT}                    //input[@placeholder="MM/DD/YYYY"]
${ZIP_INPUT}                    //input[@placeholder="Eg: 02111"]
${EMAIL_INPUT}                  //input[@placeholder="Eg: john@doe.com"]
${PHONE_INPUT}                  //input[@placeholder="Phone number"]
${CLICK_REGISTER}               //div[text()='Register']
${REGISTER_BUTTON}              (//div[contains(text(),'Register')])[2]
${NO_MEMBER_MESSAGE}            //p[contains(text(),'No matching member found')]
${SUCCESS_MESSAGE}              //div[@class='success-message']
${ERROR_MESSAGE}                //div[text()='Login Details']//preceding::div[5]


*** Keywords ***

Registration Test Template
    [Arguments]    ${username}    ${password}    ${confirm_password}    ${firstname}    ${lastname}    ${dob}    ${zip}    ${email}    ${phone}    ${expected_error}

    Open Login Page     ${URL}
    Enter Group Code    ${GROUP_CODE}
    Agree Terms
    Click Register
    Fill Registration Form    ${username}    ${password}    ${confirm_password}    ${firstname}    ${lastname}    ${dob}    ${zip}    ${email}    ${phone}
    Submit Registration Form

    Run Keyword If    '${expected_error}' != ''    Handle Registration Error    ${expected_error}
    #Run Keyword If    '${expected_error}' == ''    Validate No Member Registration    ${expected_error}
    Close Browser

Handle Registration Error
    [Arguments]    ${expected_error}
    Run Keyword If    'No matching member found' in '${expected_error}'    Validate No Member Registration    ${expected_error}
    Run Keyword If    'No matching member found' not in '${expected_error}'    Validate Registration Error Message    ${expected_error}



Register User
    FOR    ${row}    IN    @{registration_data}
        ${username}=           Set Variable    ${row['Username']}
        ${password}=           Set Variable    ${row['Password']}
        ${confirm_password}=   Set Variable    ${row['Confirm Password']}
        ${firstname}=          Set Variable    ${row['First Name']}
        ${lastname}=           Set Variable    ${row['Last Name']}
        ${dob}=                Set Variable    ${row['DOB']}
        ${zip}=                Set Variable    ${row['ZIP']}
        ${email}=              Set Variable    ${row['Email']}
        ${phone}=              Set Variable    ${row['Phone']}
        ${expected_error}=     Set Variable    ${row['Expected Error']}

        Registration Test Template    ${username}    ${password}    ${confirm_password}    ${firstname}    ${lastname}    ${dob}    ${zip}    ${email}    ${phone}    ${expected_error}
    END

Fill Registration Form
    [Arguments]    ${username}    ${password}    ${confirm_password}    ${firstname}    ${lastname}    ${dob}    ${zip}    ${email}    ${phone}
    Input Text    ${LOGIN_USERNAME_INPUT}    ${username}
    Input Text    ${PASSWORD_INPUT}    ${password}
    Input Text    ${CONFIRM_PASSWORD_INPUT}    ${confirm_password}
    Input Text    ${FIRST_NAME_INPUT}    ${firstname}
    Input Text    ${LAST_NAME_INPUT}    ${lastname}
    Input Text    ${DOB_INPUT}    ${dob}
    Input Text    ${ZIP_INPUT}    ${zip}
    Input Text    ${EMAIL_INPUT}    ${email}
    Input Text    ${PHONE_INPUT}    ${phone}

Submit Registration Form
    Wait Until Element Is Visible    ${REGISTER_BUTTON}    timeout=60
    Click Element    ${REGISTER_BUTTON}

Validate Registration Error Message
    [Arguments]    ${expected_error}
    Wait Until Element Is Visible    ${ERROR_MESSAGE}    timeout=60
    ${actual_error_message}=    Get Text    ${ERROR_MESSAGE}
    Log    Actual Error Message: ${actual_error_message}
    Log    Expected Error Message: ${expected_error}
    Should Be Equal    ${actual_error_message}    ${expected_error}    Error message does not match!

Validate No Member Registration
    [Arguments]    ${expected_error}
    Wait Until Element Is Visible    ${NO_MEMBER_MESSAGE}    timeout=60
    ${actual_error_message}=    Get Text    ${NO_MEMBER_MESSAGE}
    Log    Actual Error Message: ${actual_error_message}
    Log    Expected Error Message: ${expected_error}
    Should Be Equal    ${actual_error_message}    ${expected_error}    Error message does not match!

Validate Registration Success
    Wait Until Element Is Visible    ${SUCCESS_MESSAGE}    timeout=60
    ${success_message}=    Get Text    ${SUCCESS_MESSAGE}
    Should Contain    ${success_message}    Registration successful

Click Register
    Click Element    ${CLICK_REGISTER}

