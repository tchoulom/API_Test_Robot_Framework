## bearer authentication needs token
*** Settings ***
Library  RequestsLibrary
Library  Collections
Library     OperatingSystem


*** Variables ***
${base_url}     https://certtransaction.elementexpress.com/
${bearer_token}     "Bearer E4F284BFADA11D01A52508ED7B92FFD7EE0905659F5DED06A4B73FC7739B48A287648801"


*** Test Cases ***
Bearer_auth_test
    create session  my_session      ${base_url}
    ${headers}      create dictionary   Authorization=${bearer_token}   Content-Type=text/xml
    ${req_body}=    get file    /Users/aayush/PycharmProjects/API_TEST/data_utilities/filexml.txt
    ${response}=     post request    my_session  /   data=${req_body}    headers=${headers}
    log to console  ${response.content}
    log to console  ${response.status_code}



