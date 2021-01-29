*** Settings ***
Library  RequestsLibrary
Library  Collections

*** Variables ***
${base_url}         https://maps.googleapis.com
${req_uri}          maps/api/place/nearbysearch/json?

*** Test Cases ***
places_api_test_case
    create session  my_session  ${base_url}
    ${params}   create dictionary  Location=-33.8670522,151.1957362     radius=500      types=food      name=harbour    key=
    ${response}=    get request     my_session  ${req_uri}  params=${params}
    log to console  ${response.content}
    log to console  ${response.status_code}