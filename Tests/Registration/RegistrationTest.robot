*** Settings ***
Library    SeleniumLibrary
Resource   /Users/saurav.tuladhar/Automation/RobotProject/Helper/common.robot
Resource   /Users/saurav.tuladhar/Automation/RobotProject/Pages/RegistrationPage.robot

*** Test Cases ***
Registration Tests
    Initialize Login Data
    Read Registration Test Data
    Register User
    Close Browser
