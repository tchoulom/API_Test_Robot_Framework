*** Settings ***
Library  RequestsLibrary
Library  Collections


*** Variables ***
${base_url}     https://reqbin.com/echo/post


*** Test Cases ***
Test_case_registration
    create session      my_session      ${base_url}
    ${body}=    create dictionary  first_name=aaysuh    last_name=paudel    email=helloworld
    ${header}=  create dictionary   Content-Type=application/json
    ${response}=    post request  my_session    /json      data=${body}    headers=${header}

    log to console  ${response.status_code}
    log to console  ${response.content}


    # validation
    ${res_body}=    convert to string  ${response.content}
    should contain  ${res_body}     "success":"true"
    ${res_status}=  convert to string  ${response.status_code}
    should contain  ${res_status}     200