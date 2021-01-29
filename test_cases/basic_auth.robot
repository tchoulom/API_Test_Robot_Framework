*** Settings ***
Library  RequestsLibrary
Library  Collections


*** Variables ***
${BASE_URL}             https://restful-booker.herokuapp.com
${AUTH}                 /auth
${USERNAME}             admin
${PASSWORD}             password123
${CONTENT_TYPE}         application/json



*** Test Cases ***
Obtain Auth Token
    ${HEADERS}=         Create Dictionary       Content-Type=${CONTENT_TYPE}  User-Agent=RobotFramework
    Create Session      my_session        ${BASE_URL}     verify=True
    ${response}=        Post Request      my_session        uri=${AUTH}     data={"username":"${USERNAME}","password":"${PASSWORD}"}      headers=${HEADERS}
    should be equal as strings      ${response.status_code}     200
