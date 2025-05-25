*** Settings ***
Resource    ../resources/keywords.robot
Library    SeleniumLibrary



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
    And i click in add a new contact button
    When i see the add contact page
    And i create any number of random contacts:    1
    And i fill up the form for adding a new contact
    And click submit button
    Sleep    10s