*** Settings ***
Library           RequestsLibrary

*** Keywords ***
Get API_PLUS JSON
    [Arguments]    ${num1}    ${num2}
    ${resp}=     GET    http://127.0.0.1:8080/plus/${num1}/${num2}
    Should Be Equal    ${resp.status_code}    ${200}
    RETURN    ${resp.json()}

*** Test Cases ***
Test API_PLUS Numbers 4 and 2 (Before Using Keywords)
    ${resp}=     GET    http://127.0.0.1:8080/plus/4/2
    Should Be Equal    ${resp.status_code}    ${200}
    ${json_resp}=    Set Variable  ${resp.json()}
    Should Be Equal    ${json_resp['plus']}    ${6}

Test API_PLUS Numbers 8.4 and 4 (Before Using Keywords)
    ${resp}=     GET    http://127.0.0.1:8080/plus/8.4/4
    Should Be Equal    ${resp.status_code}    ${200}
    ${json_resp}=    Set Variable  ${resp.json()}
    Should Be Equal    ${json_resp['plus']}    ${12.4}

Test API_PLUS Numbers 12.8 and 7.2 (Before Using Keywords)
    ${resp}=     GET    http://127.0.0.1:8080/plus/12.8/7.2
    Should Be Equal    ${resp.status_code}    ${200}
    ${json_resp}=    Set Variable  ${resp.json()}
    Should Be Equal    ${json_resp['plus']}    ${20}

Test API_PLUS Numbers Word and 4 (Before Using Keywords)
    ${resp}=     GET    http://127.0.0.1:8080/plus/word/4
    Should Be Equal    ${resp.status_code}    ${200}
    ${json_resp}=    Set Variable  ${resp.json()}
    Should Be Equal    ${json_resp['error_msg']}    Invalid input

Test API_PLUS Numbers Hello and World (Before Using Keywords)
    ${resp}=     GET    http://127.0.0.1:8080/plus/Hello/World
    Should Be Equal    ${resp.status_code}    ${200}
    ${json_resp}=    Set Variable  ${resp.json()}
    Should Be Equal    ${json_resp['error_msg']}    Invalid input

Test API_PLUS Numbers 4 and 2
    ${json_resp}=    Get API_PLUS JSON    ${4}    ${2}
    Should Be Equal    ${json_resp['plus']}    ${6}

Test API_PLUS Numbers 8.4 and 4
    ${json_resp}=    Get API_PLUS JSON    ${8.4}    ${4}
    Should Be Equal    ${json_resp['plus']}    ${12.4}

Test API_PLUS Numbers 12.8 and 7.2
    ${json_resp}=    Get API_PLUS JSON    ${12.8}    ${7.2}
    Should Be Equal    ${json_resp['plus']}    ${20}

Test API_PLUS Numbers Word and 4
    ${json_resp}=    Get API_PLUS JSON    word    ${4}
    Should Be Equal    ${json_resp['error_msg']}    Invalid input

Test API_PLUS Numbers Hello and World
    ${json_resp}=    Get API_PLUS JSON    Hello    World
    Should Be Equal    ${json_resp['error_msg']}    Invalid input