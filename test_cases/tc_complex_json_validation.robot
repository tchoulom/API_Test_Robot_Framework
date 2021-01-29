*** Settings ***
Library  Collections
Library  os
Library  JSONLibrary
Library  RequestsLibrary


*** Variables ***
${base_url}     https://restcountries.eu


*** Test Cases ***

get_country_detail
      create session  my_session      ${base_url}
      ${response}=  get request       my_session  /rest/v2/alpha/IN
      ${json_object}=   to json     ${response.content}

      ## single data validation
      ${con_name}=  get value from json   ${json_object}      $.name
      log to console    ${con_name[0]} # use index since value is returned as list
      should be equal  ${con_name[0]}      India

      ## single data validation in array
      ${border_name}=  get value from json  ${json_object}      $.borders[0]
      log to console  ${border_name[0]}
      should be equal  ${border_name[0]}    AFG

      ## multiple data validation in array
       ${border_names}=  get value from json  ${json_object}      $.borders
      log to console  ${border_names[0]}
      should contain any    ${border_name[0]}    AFG    NPL     CHN     html  # TRUE IF ANY ONE OF THEM PRESENT
      should not contain any   ${border_name[0]}    NPL     HTML  # TRUE IF ANY ONE OF THEM PRESENT



