*** Settings ***
Library           RequestsLibrary

*** Keywords ***
Get plus JSON
    [Arguments]    ${num1}    ${num2}
    ${resp}=     Get Request    http://127.0.0.1:5000/plus/${num1}/${num2}
    Should Be Equal    ${resp.status_code}    ${200}
    [return]    ${resp.json()}

*** Test Cases ***
Test plus Numbers 4 and 2 (Direct Call)
    ${resp}=     Get Request    http://127.0.0.1:5000/plus/4/2
    Should Be Equal    ${resp.status_code}    ${200}
    ${json_resp}=    Set Variable    ${resp.json()}
    Should Be Equal    ${json_resp['plus']}    ${6}

Test plus Numbers 8.4 and 4 (Direct Call)
    ${resp}=     Get Request    http://127.0.0.1:5000/plus/8.4/4
    Should Be Equal    ${resp.status_code}    ${200}
    ${json_resp}=    Set Variable    ${resp.json()}
    Should Be Equal    ${json_resp['plus']}    ${12.4}

Test plus Numbers 4 and 2 (Using Keyword)
    ${json_resp}=    Get plus JSON    ${4}    ${2}
    Should Be Equal    ${json_resp['plus']}    ${6}

Test plus Numbers 8.4 and 4 (Using Keyword)
    ${json_resp}=    Get plus JSON    ${8.4}    ${4}
    Should Be Equal    ${json_resp['plus']}    ${12.4}
