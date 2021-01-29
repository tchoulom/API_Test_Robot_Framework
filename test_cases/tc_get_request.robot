*** Settings ***
Library  RequestsLibrary
Library  Collections        # to work with dictionary
*** Variables ***
${base_url}     https://jsonplaceholder.typicode.com
${rest}         todos/1


*** Test Cases ***
get_weather_info
    create session       my_session      ${base_url}
    ${my_response}=     get request     my_session      ${rest}
#    log to console      ${my_response.status_code}
#    log to console      ${my_response.content}
#    log to console      ${my_response.headers}

##   validations
     ${status_code}=   convert to string  ${my_response.status_code}
     should be equal    ${status_code}      200

     ${response_content}=  convert to string     ${my_response.content}
     should contain     ${response_content}    delectus

     ${reponse_header}=     convert to string       ${my_response.headers}
     should contain     ${reponse_header}       Express

     ${content_type_value}=   get from dictionary  ${my_response.headers}    Content-Type
     should contain  ${content_type_value}      application/json




