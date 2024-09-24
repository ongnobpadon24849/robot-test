*** Settings ***
Library           RequestsLibrary

*** Keywords ***
Get Calculation JSON
    [Arguments]    ${num1}    ${num2}
    ${resp}=     GET    http://127.0.0.1:8080/plus/${num1}/${num2}

    # Verify the status code is 200 (OK) for valid inputs
    Should Be Equal    ${resp.status_code}    ${200}

    # Get the response content as a JSON object
    RETURN    ${resp.json()}


*** Test Cases ***
Test Calculate Numbers 4 and 2 (Before Using Keywords)
    ${resp}=     GET    http://127.0.0.1:8080/plus/4/2
    Should Be Equal    ${resp.status_code}    ${200}
    ${json_resp}=    Set Variable  ${resp.json()}
    Should Be Equal    ${json_resp['plus']}    ${6}

Test Calculate Numbers 8.4 and 4 (Before Using Keywords)
    ${resp}=     GET    http://127.0.0.1:8080/plus/8.4/4
    Should Be Equal    ${resp.status_code}    ${200}
    ${json_resp}=    Set Variable  ${resp.json()}
    Should Be Equal    ${json_resp['plus']}    ${12.4}

Test Calculate Numbers word and 4 (Before Using Keywords)
    ${resp}=     GET    http://127.0.0.1:8080/plus/word/4
    Should Be Equal    ${resp.status_code}    ${400}
    ${json_resp}=    Set Variable  ${resp.json()}
    Should Be Equal    ${json_resp['plus']}    ${Invalid input}

Test Calculate Numbers 4 and 2
    ${json_resp}=    Get Calculation JSON    ${4}    ${2}
    Should Be Equal    ${json_resp['plus']}    ${6}

Test Calculate Numbers 8.4 and 4
    ${json_resp}=    Get Calculation JSON    ${8.4}    ${4}
    Should Be Equal    ${json_resp['plus']}    ${12.4}

Test Calculate Numbers word and 4
    ${json_resp}=    Get Calculation JSON    ${word}    ${4}
    Should Be Equal    ${json_resp['plus']}    ${Invalid input}
