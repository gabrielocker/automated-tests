*** Settings ***
Resource    ../resources/keywords.robot



*** Test Cases ***

Create user
    #Given i am on the initial page
    And i create a random user
    ${first_name}=    And i get the attribute of the user:    name.first
    ${last_name}=    And i get the attribute of the user:    name.last


Login website
    Given i am on the initial page
    And click sign up button
    And i create a random user
    And fill up the form for a new user 
    And click submit button
    Then i should see the contact list page
    And i click in logout
    Then i input a email and password
    And click submit button
    Then i should see the contact list page
    [Teardown]    Close Browser



Adding contact
    Given i am on the initial page
    And click sign up button
    And i create a random user
    And fill up the form for a new user
    And click submit button
    Then i should see the contact list page
    And i click in logout
    Then i input a email and password
    And click submit button
    And i should see the contact list page
    ${number_contacts}=    And i create any number of random contacts:    5
    And i fill up the form for adding new contacts    ${number_contacts}