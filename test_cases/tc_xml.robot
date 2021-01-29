*** Settings ***
Library  XML    #to parse XML file
Library  os
Library  Collections


*** Test Cases ***
test_case
    ${xml_object}=  parse xml   /Users/aayush/PycharmProjects/API_TEST/data_utilities/food.xml


    # validation: single_element_validation
    # approach1: -- to get the element value
    ${food_name}=   get element text  ${xml_object}     .//food[2]/name

    should be equal  ${food_name}       Strawberry Belgian Waffles

    ## approach:2 -- to get the element instead of element value

    ${food_element}=    get element  ${xml_object}      .//food[2]/name
    should be equal  ${food_element.text}   Strawberry Belgian Waffles

    ## approach3: direct appraoch
    element text should be  ${xml_object}    Strawberry Belgian Waffles     .//food[2]/name

    ## validation: Check for number of element(nodes)--child nodes-- in a given element
    ## check how many nodes with name price are there
    ${count}=   get element count  ${xml_object}    .//food/price
    ${count_string}=    convert to string  ${count}
    should be equal  ${count_string}   5        # to compare strings
    should be equal as integers  ${count}   5   # to compare integer

    ##validation: check if attribute is present in the XML ??
    element attribute should be  ${xml_object}     id  1     .//food[1]  # check if attribute id contains 1

    element attribute should be  ${xml_object}     id  5      .//food[5]  # check if attribute id contains 5

    ## validation:: verify content/values in the child node
    ${child_food_1}=    get child elements  ${xml_object}   .//food[1]          # get all the child element from parent elemnt food
    should not be empty  ${child_food_1}
    log to console  ${child_food_1} #attribute name values stored as pointer
    ${food_name}=   get element text  ${child_food_1[0]}
    should be equal  ${food_name}   Belgian Waffles
    ${food_price}=  get element text    ${child_food_1[1]}
    should be equal  ${food_price}  $5.95
    ${food_desc}=  get element text    ${child_food_1[2]}
    should be equal  ${food_desc}   Two of our famous Belgian Waffles with plenty of real maple syrup










