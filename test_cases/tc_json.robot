*** Settings ***
Library  JSONLibrary
Library  os     ## for accessing files using path
Library  Collections    # we want to deal with list, dictionary


*** Test Cases ***

test_case_1
   ${json_object}=   load json from file   /Users/aayush/PycharmProjects/API_TEST/data_utilities/name.json
   ${firstname}=    get value from json  ${json_object}    $.firstname  ## var is a list
   ${streetname}=   get value from json  ${json_object}   $.address.street
   ${mobilenumber}=     get value from json     ${json_object}  $.contact[1].number
#   log to console  ${firstname[0]}

    # validations
    should be equal  ${firstname[0]}    Aayush
    should be equal   ${streetname[0]}      21 street
    should be equal     ${mobilenumber[0]}  987656