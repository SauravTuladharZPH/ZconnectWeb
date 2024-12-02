*** Settings ***
Library    SeleniumLibrary
Resource   ../../Helper/common.robot
Resource   ../../Pages/RegistrationPage.robot

*** Test Cases ***
Registration Tests
    Initialize Login Data
    Read Registration Test Data
    Register User
    Close Browser
