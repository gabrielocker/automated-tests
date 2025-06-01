*** Settings ***
Resource    ../resources/keywords.robot



*** Test Cases ***

Create user, log in then log out
    [Documentation]    Create random user, use method "call api" for register new user, log in and log out
    Given i create a random user
    ${body_user}    ${password}=    And i mount the body for creating a user
    Log    ${password}
    ${body_json}=    And add user    ${URLAPP}    ${ENDPOINT_ADD_USER}    POST    ${body_user}    #create new user
    ${bearer}=    And i login    ${URLAPP}    ${ENDPOINT_LOGIN}    POST    ${body_json}    ${password}
    Then i logout    ${URLAPP}    ${ENDPOINT_LOGOUT}    POST    ${bearer}


Add new contact
    [Documentation]    Create random user, use method "call api" for register new user, log in and then add a new contact
    Given i create a random user
    ${body_user}    ${password}=    And i mount the body for creating a user
    Log    ${password}
    ${body_json}=    And add user    ${URLAPP}    ${ENDPOINT_ADD_USER}    POST    ${body_user}    #create new user
    ${bearer}=    And i login    ${URLAPP}    ${ENDPOINT_LOGIN}    POST    ${body_json}    ${password}
    ${number_contacts}=    And i create any number of random contacts:    1
    And i add any number of contacts    ${number_contacts}    ${URLAPP}    ${ENDPOINT_ADD_CONTACT}    POST    ${bearer}    #this keyword also checks the AddUser return information