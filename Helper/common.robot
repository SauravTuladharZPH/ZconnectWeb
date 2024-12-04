*** Settings ***
Library    BuiltIn
Library    ../Helper/ExcelKeywords.py

*** Variables ***
${EXCEL_FILE}     Resources/user_data.xlsx
${LOGIN_SHEET_NAME}     LoginData
${CARE_SHEET_NAME}      CareAndClaims
${CostEstimator_SHEET_NAME}      CostEstimator
${REGISTRATION_SHEET_NAME}     RegistrationData
${HOMEPAGE_SHEET_NAME}     HomeMenu
${SIDEBAR_SHEET_NAME}     SideBar


*** Keywords ***
Initialize Login Data
    ${url}=           Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    A2
    ${group_code}=    Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    B2
    ${username}=      Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    C2
    ${password}=      Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    D2
    ${invalidPassword}=      Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    D3
    ${invalidUsername}=      Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    C4
    ${invalidCredentialsError}=      Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    E3
    ${noUserError}=      Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    E4
    ${EmptyUsernameError}=      Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    E5
    ${EmptyPasswordError}=      Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    E6
    ${EmptyUsernameAndPasswordError}=      Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    E7
    ${EmptyGroupCodeError}=      Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    E8
    ${InvalidGroupCodeError}=      Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    E9
    ${InvalidGroupCode}=      Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    B3
    ${ForgotUserNotExists}=      Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    E10
    ${ForgotUser}=      Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    C5
    ${NewPassword}=      Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    D4
    ${ConfirmNewPassword}=      Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    D4
    ${PasswordChangedMsg}=      Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    E11
    ${ForgotEmail}=      Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    C6
    ${ForgotEmailSuccessMessage}=      Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    E12
    ${EmailPassword}=      Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    D5
    ${SenderEmail}=      Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    C7
    ${EmailSubject}=      Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    E13
    ${UsernameEmailSubject}=      Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    E14
    ${ForgotGroup}=      Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    B4
    ${ForgotLoginCode}=      Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    B2
    ${HelpMessage}=      Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    E15
    ${GroupPageUrl}=      Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    A3

    ${LocateFirstName}=      Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    C8
    ${LocateLastName}=      Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    C9
    ${LocateZip}=      Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    C10
    ${LocateYear}=      Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    C11
    ${LocateMonth}=      Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    C12
    ${LocateDay}=      Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    C13

    ${UsernameLocateSubject}=      Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    E16
    ${LocateClientName}=      Read Excel Data    ${EXCEL_FILE}    ${LOGIN_SHEET_NAME}    C14




    Set Suite Variable    ${URL}           ${url}
    Set Suite Variable    ${GROUP_CODE}    ${group_code}
    Set Suite Variable    ${USERNAME}      ${username}
    Set Suite Variable    ${PASSWORD}      ${password}
    Set Suite Variable    ${INVALIDPASSWORD}      ${invalidPassword}
    Set Suite Variable    ${INVALIDUSERNAME}      ${invalidUsername}
    Set Suite Variable    ${INVALIDCREDENTIALSERROR}      ${invalidCredentialsError}
    Set Suite Variable    ${NOUSERERROR}      ${noUserError}
    Set Suite Variable    ${EMPTYUSERNAMEERROR}      ${EmptyUsernameError}
    Set Suite Variable    ${EMPTYPASSWORDERROR}      ${EmptyPasswordError}
    Set Suite Variable    ${EMPTYUSERNAMEANDPASSWORDERROR}      ${EmptyUsernameAndPasswordError}
    Set Suite Variable    ${EMPTYGROUPCODEERROR}      ${EmptyGroupCodeError}
    Set Suite Variable    ${INVALIDGROUPCODEERROR}      ${InvalidGroupCodeError}
    Set Suite Variable    ${INVALIDGROUPCODE}      ${InvalidGroupCode}
    Set Suite Variable    ${FORGOTUSERNOTEXISTS}      ${ForgotUserNotExists}
    Set Suite Variable    ${FORGETUSER}      ${ForgotUser}
    Set Suite Variable    ${NEWPASSWORD}      ${NewPassword}
    Set Suite Variable    ${CONFIRMNEWPASSWORD}      ${ConfirmNewPassword}
    Set Suite Variable    ${PASSWORDCHANGEDMESSAGE}      ${PasswordChangedMsg}
    Set Suite Variable    ${FORGOTEMAIL}      ${ForgotEmail}
    Set Suite Variable    ${FORGOTEMAILSUCCESSMESSAGE}      ${ForgotEmailSuccessMessage}
    Set Suite Variable    ${EMAIL_USER}      ${ForgotEmail}
    Set Suite Variable    ${EMAIL_PASSWORD}      ${EmailPassword}
    Set Suite Variable    ${SENDER_EMAIL}      ${SenderEmail}
    Set Suite Variable    ${EMAIL_SUBJECT}      ${EmailSubject}
    Set Suite Variable    ${USERNAME_EMAIL_SUBJECT}      ${UsernameEmailSubject}
    Set Suite Variable    ${FORGOT_GROUP}      ${ForgotGroup}
    Set Suite Variable    ${FORGOT_LOGIN_CODE}      ${ForgotLoginCode}
    Set Suite Variable    ${FORGOT_USERNAME}      ${ForgotUser}
    Set Suite Variable    ${FORGOT_EMAIL_ADDRESS}      ${ForgotEmail}

    Set Suite Variable    ${HELP_GROUP_ID}      ${group_code}
    Set Suite Variable    ${HELP_MESSAGE}      ${HelpMessage}
    Set Suite Variable    ${GROUP_PAGE_URL}      ${GroupPageUrl}

    Set Suite Variable    ${LOCATE_FIRSTNAME}      ${LocateFirstName}
    Set Suite Variable    ${LOCATE_LASTNAME}      ${LocateLastName}
    Set Suite Variable    ${LOCATE_ZIP}      ${LocateZip}
    Set Suite Variable    ${LOCATE_YEAR}      ${LocateYear}
    Set Suite Variable    ${LOCATE_MONTH}      ${LocateMonth}
    Set Suite Variable    ${LOCATE_DAY}      ${LocateDay}

    Set Suite Variable    ${USERNAME_LOCATE_SUBJECT}      ${UsernameLocateSubject}
    Set Suite Variable    ${USERNAME_LOCATE_CLIENTNAME}      ${LocateClientName}




Initialize Care And Claims Data
    ${care_url}=           Read Excel Data    ${EXCEL_FILE}    ${CARE_SHEET_NAME}    B2
    ${expected_text}=      Read Excel Data    ${EXCEL_FILE}    ${CARE_SHEET_NAME}    C2
    ${expected_textAccumulatorYear}=      Read Excel Data    ${EXCEL_FILE}    ${CARE_SHEET_NAME}    C3
    ${expected_textCareAndClaimDetailOpened}=      Read Excel Data    ${EXCEL_FILE}    ${CARE_SHEET_NAME}    C4
    ${expected_textCareAndClaimMedicalDetailOpened}=      Read Excel Data    ${EXCEL_FILE}    ${CARE_SHEET_NAME}    C5
    ${expected_textCareAndClaimPharmacyDetailOpened}=      Read Excel Data    ${EXCEL_FILE}    ${CARE_SHEET_NAME}    C6
    ${expected_textUncheckSelfNoRecord}=      Read Excel Data    ${EXCEL_FILE}    ${CARE_SHEET_NAME}    C7

    Set Suite Variable    ${CAREANDCLAIMURL}    ${care_url}
    Set Suite Variable    ${CAREANDCLAIMEXPECTEDTEXT}    ${expected_text}
    Set Suite Variable    ${CAREANDCLAIMACCUMULATORYEAREXPECTEDTEXT}    ${expected_textAccumulatorYear}
    Set Suite Variable    ${CareAndClaimDetailOpenedEXPECTEDTEXT}    ${expected_textCareAndClaimDetailOpened}
    Set Suite Variable    ${CareAndClaimMedicalDetailOpenedEXPECTEDTEXT}    ${expected_textCareAndClaimMedicalDetailOpened}
    Set Suite Variable    ${CareAndClaimPharmacyDetailOpenedEXPECTEDTEXT}    ${expected_textCareAndClaimPharmacyDetailOpened}
    Set Suite Variable    ${FamilySelfUncheckEXPECTEDTEXT}    ${expected_textUncheckSelfNoRecord}


Initialize Cost Estimator Data
    ${CostEstimator_url}=           Read Excel Data    ${EXCEL_FILE}    ${CostEstimator_SHEET_NAME}    B2
    ${CostEstimatorExpected_text}=      Read Excel Data    ${EXCEL_FILE}    ${CostEstimator_SHEET_NAME}    C2
    Set Suite Variable    ${COSTESTIMATORURL}    ${CostEstimator_url}
    Set Suite Variable    ${COSTESTIMATOREXPECTEDTEXT}    ${CostEstimatorExpected_text}


Verify Browser Session
    ${status}=    Run Keyword And Return Status    Get Location
    Run Keyword If    not ${status}    Fail    Browser session is not active!


Read Registration Test Data
    @{registration_data}=    Read Excel Registration Data    ${EXCEL_FILE}    ${REGISTRATION_SHEET_NAME}
    Set Suite Variable    ${registration_data}    ${registration_data}


Fetch OTP Test
    ${otp}=    Fetch Otp From Gmail    ${EMAIL_USER}    ${EMAIL_PASSWORD}    ${SENDER_EMAIL}    ${EMAIL_SUBJECT}
    Log    OTP Retrieved: ${otp}
    Set Suite Variable    ${OTP}    ${otp}


Validate Username Test
    ${userDetails}=    Validate Username From Gmail    ${EMAIL_USER}    ${EMAIL_PASSWORD}    ${SENDER_EMAIL}    ${USERNAME_EMAIL_SUBJECT}    ${FORGOT_USERNAME}    ${FORGOT_GROUP}    ${FORGOT_LOGIN_CODE}    ${FORGOT_EMAIL_ADDRESS}
    Log     Retrieved: ${userDetails}
    Set Suite Variable    ${FORGOTUSERNAMEDETAILS}    ${userDetails}


Validate Locate Information Test
    ${locateDetails}=    Validate LocateInformation From Gmail    ${EMAIL_USER}    ${EMAIL_PASSWORD}    ${SENDER_EMAIL}    ${USERNAME_LOCATE_SUBJECT}    ${USERNAME_LOCATE_CLIENTNAME}    ${FORGOT_GROUP}    ${FORGOT_LOGIN_CODE}    ${FORGOT_USERNAME}
    Log     Retrieved: ${locateDetails}
    Set Suite Variable    ${FORGOTLOCATEDETAILS}    ${locateDetails}


Read Homepage Test Data
    ${menu_items}=    Read HomepageMenu From Excel    ${EXCEL_FILE}    ${HOMEPAGE_SHEET_NAME}
    Log Many          @{menu_items}
    RETURN          ${menu_items}



Read Homepage Menu Test Data
    ${menu_data}=    Read Homepage Menu Data From Excel    ${EXCEL_FILE}    ${HOMEPAGE_SHEET_NAME}
    Log Many         ${menu_data}
    RETURN           ${menu_data}