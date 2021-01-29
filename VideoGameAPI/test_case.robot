*** Settings ***
Library  RequestsLibrary
Library     Collections  ## since we need dictionary object to maintain the data



*** Variables ***
${id}   100

${base_url}     http://localhost:8080

*** Test Cases ***

test_case_get_return_all_video_games
    # Returns all the videos games in the DB

    create session  my_session      ${base_url}
    ${response}=   get request  my_session     /app/videogames  # gives data from database

    log to console      ${response.status_code}
    log to console      ${response.content}

    # Validations

    ${res_status}=  convert to string  ${response.status_code}
    should be equal  ${res_status}      200


test_case_post_add_videogame_record
    # Add a new video game to the DB

    create session  my_session     ${base_url}
    ${body}=    create dictionary   id=100  name=X-man  releaseDate=2021-01-26T14:03:32.441Z   reviewScore=67  category=Action  rating=9.8
    ${header}=  create dictionary   Content-Type=application/json
    ${response}=     post request  my_session     /app/videogames    data=${body}      headers=${header}
    log to console      ${response.status_code}
    log to console     ${response.content}

    #validations
    ${sta_code}=    convert to string  ${response.status_code}
    should be equal  ${sta_code}    200
    ${res_body}=    convert to string  ${response.content}
    should contain      ${res_body}     Record Added Successfully


test_case_get_single_data_using_id
    # Returns the details of a single game by ID
    create session  my_session  ${base_url}
    ${response}=    get request  my_session     app/videogames/${id}
    log to console  ${response.status_code}
    log to console  ${response.content}

    #validations
    ${status}=  convert to string  ${response.status_code}
    should be equal  ${status}      200
    ${content}=     convert to string   ${response.content}
    should contain  ${content}      X-man   # name of the game we have inserted using post


test_case_put_update_data
    # Update an existing video game in the DB by specifying a new body
    create session  my_session  ${base_url}
    ${body}=    create dictionary   id=100  name=X-man-returns  releaseDate=2021-01-26T14:03:32.441Z   reviewScore=67  category=Action  rating=9.8
    ${header}=  create dictionary  Content-Type=application/json
    ${response}=    put request  my_session    /app/videogames/${id}    data=${body}    headers=${header}


    log to console      ${response.status_code}
    log to console      ${response.content}

    ## validation
    ${status_code}=     convert to string  ${response.status_code}
    should be equal  ${status_code}     200
    ${data}=    convert to string  ${response.content}
    should contain  ${data}     X-man-returns

test_case_delete_record
    # Deletes a video game from the DB by ID
    create session  my_session  ${base_url}
    ${response}=    delete request  my_session  /app/videogames/${id}
    log to console      ${response.status_code}
    log to console      ${response.content}

    # validations
    ${status}=  convert to string  ${response.status_code}
    should be equal  ${status}      200
    ${content}=     convert to string  ${response.content}
    should contain  ${content}  Record Deleted Successfully




