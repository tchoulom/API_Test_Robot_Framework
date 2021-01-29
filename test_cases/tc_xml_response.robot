*** Settings ***
Library  XML
Library  os
Library  Collections
Library     RequestsLibrary


*** Variables ***
${base_url}     https://api.intacct.com


*** Test Cases ***

my_test_case
    create session  my_session  ${base_url}
    ${response}=    get request     my_session  /ia/xml/xmlgw.phtml
    ## CONVERT TO STRING BEFORE PARSING
    ${xml_string}=  convert to string  ${response.content}
    ${xml_object}=  parse xml  ${xml_string}
#    log to console      ${xml_object}

    # check single element text value
    element text should be  ${xml_object}    failure        .//control/status

    # check multiple values
     ${child}=   get child elements  ${xml_object}
     should not be empty  ${child}

     ${control}=    get element text  ${child[0]}
     ${control_child}=   get child elements   ${child[0]}
     ${status}=      get element text  ${control_child[0]}

     ${error}=   get child elements  ${child[1]}
     ${error_child}=     get child elements  ${error[0]}

     ${error_num}=   get element text  ${error_child[0]}
     ${error_msg}=   get element text  ${error_child[1]}

     should be equal  ${status}     failure
     should be equal  ${error_num}   XMLGW_JPP0002
     should be equal  ${error_msg}   Sign-in information is incorrect. Please check your request.



