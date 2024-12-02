*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn
Library    RetryFailed    3    5
Library    ../Helper/ExcelKeywords.py
Library    ../Helper/CustomActions.py



*** Keywords ***
Click Cost Estimator Menu

    Sleep    5s

    Reload Page

    Wait Until Element Is Visible    //div[text()='Cost Estimator']    timeout=40    error=Cost Estimator button did not become visible
    Wait Until Element Is Enabled    //div[text()='Cost Estimator']    timeout=40    error=Cost Estimator button is not enabled for interaction

    Sleep    10s

    Execute JavaScript    var overlay = document.querySelector('.modal-overlay'); if (overlay) overlay.style.display='none';

    Execute JavaScript    var element = document.evaluate("//div[text()='Cost Estimator']//ancestor::div[2][@role='button']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; if (element) { element.setAttribute('type', 'button'); element.style.border='3px solid red'; element.dispatchEvent(new MouseEvent('click', { bubbles: true, cancelable: true })); }

    Wait Until Element Is Enabled    //div[text()='Cost Estimator']    timeout=40    error=Cost Estimator button did not become visible

    Execute JavaScript    var element = document.evaluate("//div[text()='Cost Estimator']//ancestor::div[2][@role='button']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; if (element) { element.focus(); element.dispatchEvent(new KeyboardEvent('keydown', { key: 'Enter', bubbles: true })); element.dispatchEvent(new KeyboardEvent('keyup', { key: 'Enter', bubbles: true })); }
    BuiltIn.Log    Javascript attempted on 'Cost Estimator' button

    Double Click Element    //div[text()='Cost Estimator']//ancestor::div[2][@role='button']
    BuiltIn.Log    Double Click attempted on 'Cost Estimator' button


    Sleep    5s


Verify Cost Estimator Opened
    [Arguments]    ${CostEstimatorURL}    ${CostEstimatorExpectedText}
    Wait Until Element Is Visible    //div[text()='Need a cost estimate for one of your enrolled dependents?']    timeout=40    error=Cost estimator page not opened
    Page Should Contain    ${CostEstimatorExpectedText}

    ${current_url}=    Get Location
    Should Contain    ${current_url}    ${CostEstimatorURL}

    Wait Until Element Is Visible    //div[text()='X']    timeout=40    error=X not clicked
    Click Element    //div[text()='X']


Search by Provider Category


    Wait Until Element Is Enabled    //span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']    timeout=40    error=Cost Estimator button did not become visible

    Execute JavaScript    var element = document.evaluate("//span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; if (element) { element.focus(); element.dispatchEvent(new KeyboardEvent('keydown', { key: 'Enter', bubbles: true })); element.dispatchEvent(new KeyboardEvent('keyup', { key: 'Enter', bubbles: true })); }
    Log    Javascript attempted on 'Cost Estimator' button

    Double Click Element    //span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']
    Log    Double Click attempted on 'Cost Estimator' button
    Press Keys    //span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']    [TAB]
    Press Keys       //span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']    [ENTER]


    Wait Until Page Contains Element    //span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']    timeout=30
    Wait Until Element Is Enabled    //span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']    timeout=40    error=Acupunture button did not become visible
    Verify Browser Session Is Active
    Custom.Click Element With Actions    //span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']


#    Sleep    5s
#
#    Wait Until Page Contains Element    //span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']    timeout=10s
#    Execute JavaScript    var element = document.evaluate("//span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; if (element) { element.setAttribute('id', 'ACCU'); element.focus(); element.style.border='3px solid red';}
#    Execute JavaScript    var element = document.evaluate("//span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; if (element) { element.setAttribute('type', 'button'); element.style.border='3px solid red'; element.dispatchEvent(new MouseEvent('click', { bubbles: true, cancelable: true })); }
#    Execute JavaScript    var element = document.evaluate("//span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; if (element) { element.setAttribute('onclick', 'handleClick()'); element.style.border='3px solid red'; element.dispatchEvent(new MouseEvent('click', { bubbles: true, cancelable: true })); }
#
#    Execute JavaScript    var divElement = document.evaluate("//span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; if (divElement) { var buttonElement = document.createElement('button'); buttonElement.innerHTML = divElement.innerHTML; buttonElement.className = divElement.className; for (var i = 0; i < divElement.attributes.length; i++) { var attr = divElement.attributes[i]; buttonElement.setAttribute(attr.name, attr.value); } divElement.parentNode.replaceChild(buttonElement, divElement); }
#
#    Wait Until Page Contains Element    //button[@id='ACCU']    timeout=10s
#
#    # Now you can interact with the new button
#    Click Element    //button[@id='ACCU']  # Use the correct XPath for the new button
#    Press Keys    //button[@id='ACCU']    [Return]
#    Execute JavaScript    var element = document.evaluate("//button[@id='ACCU']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; if (element) { element.focus(); element.dispatchEvent(new KeyboardEvent('keydown', { key: 'Enter', bubbles: true })); element.dispatchEvent(new KeyboardEvent('keyup', { key: 'Enter', bubbles: true })); }
#    Double Click Element    //button[@id='ACCU']



#    # Define the target element and success element
#    ${target_element}=    Set Variable    xpath=//span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']
#    ${success_element}=   Set Variable    xpath=//div[text()='ACUPUNCTURE']
#
#    # Ensure page and target element are ready
#    Reload Page
#    Wait Until Page Contains Element    ${target_element}    timeout=40s    error=Target element not found
#    Wait Until Element Is Visible      ${target_element}    timeout=40s    error=Target element not visible
#    Wait Until Element Is Enabled      ${target_element}    timeout=40s    error=Target element not enabled
#    Execute JavaScript    var element = document.evaluate("//span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; if (element) { element.setAttribute('onclick', 'handleClick()'); element.style.border='3px solid red'; element.dispatchEvent(new MouseEvent('click', { bubbles: true, cancelable: true })); }
#
#    # Try using Execute JavaScript to bypass overlays or JS issues
#    Execute JavaScript    var overlay = document.querySelector('.modal-overlay'); if (overlay) overlay.style.display='none';
#    Execute JavaScript    var element = document.evaluate("//span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; if (element) { element.scrollIntoView({behavior: 'smooth', block: 'center'}); element.style.border='3px solid red'; }
#    Execute JavaScript    var element = document.evaluate("//span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; if (element) { element.setAttribute('type', 'button'); element.style.border='3px solid red'; element.dispatchEvent(new MouseEvent('click', { bubbles: true, cancelable: true })); }
#
#    Execute JavaScript    var element = document.evaluate("//span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; if (element) { element.setAttribute('id', 'ACCU'); element.focus(); element.style.border='3px solid red';}
#    # Retry clicking with multiple approaches
#    FOR    ${i}    IN RANGE    1    5
#        Log    Attempt ${i} to click the target element
#        Run Keyword And Ignore Error    Click Element    ${target_element}
#        Run Keyword And Ignore Error    Double Click Element    ${target_element}
#        Run Keyword And Ignore Error    Execute JavaScript    var element = document.evaluate("//span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; if (element) element.dispatchEvent(new MouseEvent('click', { bubbles: true, cancelable: true }));
#        Run Keyword And Ignore Error    Execute JavaScript    var element = document.evaluate("//span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; if (element) { element.focus(); element.dispatchEvent(new KeyboardEvent('keydown', { key: 'Enter', bubbles: true })); element.dispatchEvent(new KeyboardEvent('keyup', { key: 'Enter', bubbles: true })); }
#        Execute JavaScript    var element = document.evaluate("//span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; if (element) { console.log('Element status:', { clickable: !element.disabled, visible: !!(element.offsetWidth || element.offsetHeight || element.getClientRects().length) }); }
#
#
#
#
#
#        Press Keys    //div[@id='ACCU']    [Return]
#
#        Execute JavaScript    var element = document.evaluate("//span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; if (element) { var touchstart = new TouchEvent('touchstart', { bubbles: true, cancelable: true }); var touchend = new TouchEvent('touchend', { bubbles: true, cancelable: true }); element.dispatchEvent(touchstart); element.dispatchEvent(touchend); }
#        Log    Touch action executed on the element
#
#        Press Keys    //span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']    [TAB]
#        Press Keys       //span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']    [ENTER]
#        # Check if success element appears
#        ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${success_element}
#        Run Keyword If    ${is_visible}    Exit For Loop
#        Sleep    5s  # Delay for retry
#    END
#
#    # Final validation
#    Wait Until Element Is Visible    ${success_element}    timeout=30s    error=Next page did not load
#    Log    Successfully clicked and loaded next page



#    Wait Until Element Is Visible    //span[text()='ACUPUNCTURE']    timeout=40    error=Acupunture not visible
#    Execute JavaScript    var overlay = document.querySelector('.modal-overlay'); if (overlay) overlay.style.display='none';
#    Execute JavaScript    var element = document.evaluate("//span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; if (element) { element.setAttribute('type', 'button'); element.style.border='3px solid red'; element.dispatchEvent(new MouseEvent('click', { bubbles: true, cancelable: true })); }
#    Wait Until Element Is Enabled    //span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']    timeout=40    error=Care And Claims History button is not enabled for interaction
#    Execute JavaScript    var element = document.evaluate("//span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; if (element) { element.focus(); element.dispatchEvent(new KeyboardEvent('keydown', { key: 'Enter', bubbles: true })); element.dispatchEvent(new KeyboardEvent('keyup', { key: 'Enter', bubbles: true })); }
#    Double Click Element    //span[text()='ACUPUNCTURE']//ancestor::div[3][@role='button']




    Wait Until Element Is Visible    //div[text()='ACUPUNCTURE']    timeout=40    error=Acupunture selectbox not visible
    Click Element    //div[text()='ACUPUNCTURE']

    Wait Until Element Is Visible    //div[text()='SINGLE VITAMIN NOS']    timeout=40    error=Provider not visible
    Click Element    //div[text()='SINGLE VITAMIN NOS']

    Wait Until Element Is Visible    //textarea[text()='ACUPUNCTURE']    timeout=40    error=Validate Selected provider failed
    Element Should Contain    //textarea[text()='ACUPUNCTURE']    ACUPUNCTURE

    Wait Until Element Is Visible    //textarea[text()='SINGLE VITAMIN NOS']    timeout=40    error=Validate Selected procedure failed
    Element Should Contain    //textarea[text()='SINGLE VITAMIN NOS']    SINGLE VITAMIN NOS

    Wait Until Element Is Visible    //div[text()='Search']    timeout=40    error=Search not visible
    Click Element    //div[text()='Search']


    ${current_url}=    Get Location
    Should Contain    ${current_url}    /provider-search-pt-result




Cost Estimator Search by Procedure
    #[Arguments]    ${CostEstimatorURL}    ${CostEstimatorExpectedText}
    Wait Until Element Is Visible    //input[@placeholder="E.g. X-ray or Hospital"]    timeout=40    error=Cost estimator page search not found

    Input Text    //input[@placeholder="E.g. X-ray or Hospital"]    SINGLE VITAMIN NOS

    Sleep    5s
    Wait Until Element Is Visible    //div[text()='Single Vitamin Nos']    timeout=30    error=Family tab did not become visible

    Click Element    (//div[text()='Single Vitamin Nos']//parent::div)[1]

    Wait Until Element Is Visible    //div[text()='Show location in map']    timeout=30    error=Search did not become visible

    Page Should Contain    Show location in map

    ${current_url}=    Get Location
    Should Contain    ${current_url}    /provider-search-pt-result




Type In Chat
    Wait Until Element Is Visible    //input[@placeholder='How can we help?']    timeout=40    error=Cost Estimator button did not become visible
    Input Text    //input[@placeholder='How can we help?']    Hello


