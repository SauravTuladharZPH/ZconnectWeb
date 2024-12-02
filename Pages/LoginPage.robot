*** Settings ***
Library    SeleniumLibrary
Library    ../Helper/ExcelKeywords.py
Resource    ../Helper/common.robot



*** Variables ***
${LOCATOR_GROUP_CODE_FIELD}          //input[@placeholder="Please enter your group code"]
${LOCATOR_VERIFY_GROUP_BUTTON}       //div[contains(text(),'VERIFY GROUP')]
${LOCATOR_TERMS_CHECKBOX_1}          (//input[@type="checkbox"])[1]
${LOCATOR_TERMS_CHECKBOX_2}          (//input[@type="checkbox"])[2]
${LOCATOR_I_AGREE_BUTTON}            //div[contains(text(),'I Agree')]
${LOCATOR_USERNAME_FIELD}            //input[@placeholder="Enter your username"]
${LOCATOR_PASSWORD_FIELD}            //input[@placeholder="Enter your password"]
${LOCATOR_LOGIN_BUTTON}              //div[contains(text(),'Login')]
${LOCATOR_GROUP_CODE_ERROR}          //div[contains(text(),'Group Code')]//preceding::div[3]
${LOCATOR_LOGIN_ERROR}               //div[@id="login_error_msg"]
${LOCATOR_FORGET_PASSWORD}           //div[contains(text(),'Forgot Password?')]
${LOCATOR_FORGET_USERNAME}           //input[@placeholder='Enter your username']
${LOCATOR_FORGET_VERIFY}            //div[contains(text(),'Verify')]
${LOCATOR_FORGET_ERROR}             //div[@class="MuiSnackbarContent-message"]
${LOCATOR_OTP_PAGE}                //div[contains(text(),'Please type the verification code ')]
${OTP_FIELDS}                      //div[contains(text(),'Please type the verification code ')]//following::input[position() <= 6]
${LOCATOR_NEW_PASSWORD}                    //input[@placeholder="Enter new password"]
${LOCATOR_CONFIRM_NEW_PASSWORD}            //input[@placeholder="Confirm new password"]
${LOCATOR_PASSWORD_CHANGED_MSG}            (//p[@id="alert-dialog-slide-description"])[3]
${LOCATOR_CONFIRM_BUTTON}            //div[contains(text(),'CONFIRM')]
${LOCATOR_FORGOT_USERNAME}            //div[contains(text(),'Forgot Username?')]
${LOCATOR_FORGOT_USERNAME_FIELD}            //input[@placeholder="Eg: john@doe.com"]
${LOCATOR_FORGOT_USERNAME_SUCCESS_VAlIDATION}            //div[@class="MuiSnackbarContent-message"]

${LOCATOR_CLICK_HELP}            //div[contains(text(),'Help?')]
${LOCATOR_GROUP_ID}            //div[contains(text(),'Change')]//preceding::div[1]
${LOCATOR_CUSTOMER_SUPPORT_MSG}            //div[contains(text(),'Change')]//following::div[3]
${LOCATOR_CHANGE}            //div[contains(text(),'Change')]
${LOCATOR_LOCATE_INFORMATION}            //span[contains(text(),' Locate Information')]
${LOCATOR_LOCATE_ACCOUNTPAGE}            //div[contains(text(),'Locate Account')]
${LOCATOR_LOCATE_FIRSTNAME}            //input[@placeholder="First Name"]
${LOCATOR_LOCATE_LASTNAME}            //input[@placeholder="Last Name"]
${LOCATOR_LOCATE_ZIPCODE}            //input[@placeholder="Eg: 02111"]

${YEAR_SELECT}     //div[contains(text(),'Date of Birth')]//following::select[1]
${MONTH_SELECT}    //div[contains(text(),'Date of Birth')]//following::select[2]
${DAY_SELECT}      //div[contains(text(),'Date of Birth')]//following::select[3]

${LOCATE_BUTTON}      //div[text()="Locate"]
${CHROME_OPTIONS}    --headless --disable-gpu --window-size=1920x1080 --no-sandbox







*** Keywords ***
Open Login Page
    [Arguments]    ${url}
    Open Browser    ${url}    chrome
    #Open Browser    https://zconnect.zakipointhealth.com    chrome
    Maximize Browser Window

Enter Group Code
    [Arguments]    ${group_code}
    Wait Until Element Is Visible    ${LOCATOR_GROUP_CODE_FIELD}    timeout=30    error=Group code field did not become visible
    Input Text    ${LOCATOR_GROUP_CODE_FIELD}    ${group_code}
    Press Keys    ${LOCATOR_VERIFY_GROUP_BUTTON}    [Return]

Agree Terms
    Wait Until Element Is Visible    ${LOCATOR_I_AGREE_BUTTON}    timeout=30    error=Agree field did not become visible
    Click Element    ${LOCATOR_TERMS_CHECKBOX_1}
    Click Element    ${LOCATOR_TERMS_CHECKBOX_2}
    Click Element    ${LOCATOR_I_AGREE_BUTTON}

Enter Credentials
    [Arguments]    ${username}    ${password}
    Wait Until Element Is Visible    ${LOCATOR_USERNAME_FIELD}    timeout=30    error=Username field did not become visible
    Input Text    ${LOCATOR_USERNAME_FIELD}    ${username}
    Input Text    ${LOCATOR_PASSWORD_FIELD}    ${password}

Click Login
    Click Element    ${LOCATOR_LOGIN_BUTTON}


Validate Group Code Error Message
    [Arguments]    ${EmptyGroupCodeError}
    Wait Until Element Is Visible    ${LOCATOR_GROUP_CODE_ERROR}    timeout=30
    ${actual_error_message}=    Get Text    ${LOCATOR_GROUP_CODE_ERROR}
    Should Be Equal    ${actual_error_message}    ${EmptyGroupCodeError}    Error message does not match!

Validate Login page Error Message
    [Arguments]    ${LoginError}
    Wait Until Element Is Visible    ${LOCATOR_LOGIN_ERROR}    timeout=30
    ${actual_error_message}=    Get Text    ${LOCATOR_LOGIN_ERROR}
    Should Be Equal    ${actual_error_message}    ${LoginError}    Error message does not match!

Forget Password Invalid User
    [Arguments]    ${ForgotUser}    ${LoginError}
    Wait Until Element Is Visible    ${LOCATOR_FORGET_USERNAME}    timeout=30
    Input Text    ${LOCATOR_FORGET_USERNAME}    ${ForgotUser}
    Click Element    ${LOCATOR_FORGET_VERIFY}
    Wait Until Element Is Visible    ${LOCATOR_FORGET_ERROR}    timeout=30
    ${actual_error_message}=    Get Text    ${LOCATOR_FORGET_ERROR}
    Should Be Equal    ${actual_error_message}    ${LoginError}    Error message does not match!

Click Forget Password
    Wait Until Element Is Visible    ${LOCATOR_FORGET_PASSWORD}     timeout=30
    Click Element    ${LOCATOR_FORGET_PASSWORD}

Forget Password
    [Arguments]    ${ForgotUser}    ${NewPassword}    ${ConfirmNewPassword}    ${PasswordChangedMsg}
    Wait Until Element Is Visible    ${LOCATOR_FORGET_USERNAME}    timeout=30
    Input Text    ${LOCATOR_FORGET_USERNAME}    ${ForgotUser}
    Click Element    ${LOCATOR_FORGET_VERIFY}
    Wait Until Element Is Visible    ${LOCATOR_OTP_PAGE}    timeout=30
    Page Should Contain    Please type the verification code
    Wait Until Element Is Visible    ${LOCATOR_OTP_PAGE}
    Input Text    ${LOCATOR_NEW_PASSWORD}    ${NewPassword}
    Input Text    ${LOCATOR_CONFIRM_NEW_PASSWORD}    ${ConfirmNewPassword}
#    Sleep    5s
    Fetch OTP Test
    Input OTP Into Fields
    Click Element    ${LOCATOR_CONFIRM_BUTTON}
    Wait Until Element Is Visible    ${LOCATOR_PASSWORD_CHANGED_MSG}    timeout=30
    ${actual_error_message}=    Get Text    ${LOCATOR_PASSWORD_CHANGED_MSG}
    Should Be Equal    ${actual_error_message}    ${PasswordChangedMsg}    Error message does not match!

Input OTP Into Fields
    Wait Until Element Is Visible    ${LOCATOR_OTP_PAGE}
    ${fields}    Get Webelements    ${OTP_FIELDS}
    ${field_count}    Get Length    ${fields}
    Log    Number of fields: ${field_count}
    FOR    ${index}    IN RANGE    0    ${field_count}
        ${digit}    Evaluate    ${OTP}[${index}]  # Access the OTP digit by index.
        Input Text    ${fields[${index}]}    ${digit}
    END

Click Forget Username
    [Arguments]    ${ForgotUsername}    ${ForgotUsernameSuccessMsg}
    Wait Until Element Is Visible    ${LOCATOR_FORGOT_USERNAME}     timeout=30
    Click Element    ${LOCATOR_FORGOT_USERNAME}
    Wait Until Element Is Visible    ${LOCATOR_FORGOT_USERNAME_FIELD}
    Input Text    ${LOCATOR_FORGOT_USERNAME_FIELD}    ${ForgotUsername}
    Click Element    ${LOCATOR_FORGET_VERIFY}
    Validate Username Test
    Wait Until Element Is Visible    ${LOCATOR_FORGOT_USERNAME_SUCCESS_VAlIDATION}    timeout=30
    ${actual_error_message}=    Get Text    ${LOCATOR_FORGOT_USERNAME_SUCCESS_VAlIDATION}
    Should Be Equal    ${actual_error_message}    ${ForgotUsernameSuccessMsg}    Error message does not match!
    ${FORGOTUSERNAMEDETAILS}=    Evaluate    str(${FORGOTUSERNAMEDETAILS})
    Should Be Equal    ${FORGOTUSERNAMEDETAILS}    True    User details in Email not matched!


Login Help
    Wait Until Element Is Visible    ${LOCATOR_CLICK_HELP}     timeout=30
    Click Element    ${LOCATOR_CLICK_HELP}
    Wait Until Element Is Visible    ${LOCATOR_GROUP_ID}    timeout=30
    ${Group_actual_text}=    Get Text    ${LOCATOR_GROUP_ID}
    Should Contain    ${Group_actual_text}    ${HELP_GROUP_ID}    Group does not match!
    ${Help_Msg_actual_text}=    Get Text    ${LOCATOR_CUSTOMER_SUPPORT_MSG}
    Should Contain    ${Help_Msg_actual_text}    ${HELP_MESSAGE}    Support Message does not match!
    Page Should Contain    Zakipoint Health
    Page Should Contain    Website: https://zakipointhealth.com
    Page Should Contain    Phone: 1-800-123-4567


Help Clicking on Change navigates to Group page
    Wait Until Element Is Visible    ${LOCATOR_CLICK_HELP}     timeout=30
    Click Element    ${LOCATOR_CLICK_HELP}
    Wait Until Element Is Visible    ${LOCATOR_CHANGE}    timeout=30
    Click Element    ${LOCATOR_CHANGE}
    ${current_url}=    Get Location
    Should Contain    ${current_url}    ${GROUP_PAGE_URL}
    Page Should Contain    Group Code


Locate Information Test
    Wait Until Element Is Visible    ${LOCATOR_LOCATE_INFORMATION}     timeout=30
    Click Element    ${LOCATOR_LOCATE_INFORMATION}
    Wait Until Element Is Visible    ${LOCATOR_LOCATE_ACCOUNTPAGE}    timeout=30
    Wait Until Element Is Visible    ${LOCATOR_LOCATE_FIRSTNAME}
    Input Text    ${LOCATOR_LOCATE_FIRSTNAME}    ${LOCATE_FIRSTNAME}
    Input Text    ${LOCATOR_LOCATE_LASTNAME}    ${LOCATE_LASTNAME}
    Input Text    ${LOCATOR_LOCATE_ZIPCODE}    ${LOCATE_ZIP}
    Select From List By Value    ${YEAR_SELECT}    ${LOCATE_YEAR}
    Select From List By Value    ${MONTH_SELECT}    ${LOCATE_MONTH}
    Select From List By Value    ${DAY_SELECT}    ${LOCATE_DAY}

    Click Element    ${LOCATE_BUTTON}
    Sleep    5s

    Validate Locate Information Test

    ${FORGOTLOCATEDETAILS}=    Evaluate    str(${FORGOTLOCATEDETAILS})
    Should Be Equal    ${FORGOTLOCATEDETAILS}    True    User details in Email not matched!

    Sleep    15s