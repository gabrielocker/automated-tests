*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    String

Library    random_user.py
Library    api_response_handler.py
Library    Collections

Resource    variables.robot


*** Keywords ***

# creating random user or contact
i create a random user
    Instance Randomuser
    ${users}=    Generate Users    1

i create any number of random contacts:
    [Arguments]    ${contacts}
    Instance Randomuser
    ${users}=    Generate Users    ${contacts}
    RETURN    ${contacts}

i get the attribute of the user:
    [Arguments]    ${requested_argument}
    ${attribute}    Get Attribute    0    ${requested_argument}
    RETURN    ${attribute}

i get the attribute a contact:
    [Arguments]    ${index_contact}    ${requested_argument}
    ${attribute}    Get Attribute    ${index_contact}    ${requested_argument}
    RETURN    ${attribute}






# navigation
click sign up button
    Wait Until Element Is Visible    id:signup
    Click Element    id:signup

see the add user page
    Wait Until Element Is Visible    xpath=//h1[contains(text(), 'Add User')]    60s

fill up the form for a new user
    ${first_name}=    And i get the attribute of the user:    name.first
    ${last_name}=    And i get the attribute of the user:    name.last
    ${email}=    And i get the attribute of the user:    email
    ${password}=    And i get the attribute of the user:    login.salt
    Input Text    id:firstName    ${first_name}
    Input Text    id:lastName    ${last_name}
    Input Text    id:email    ${email}
    Input Text    id:password    ${password}

click submit button
    Wait Until Element Is Visible    id:submit
    Click Element    id:submit

click cancel button
    Wait Until Element Is Visible    id:cancel
    Click Element    id:cancel

i am on the initial page
    Open Browser    ${URLAPP}    chrome

i input a email and password
    ${email}=    And i get the attribute of the user:    email
    ${password}=    And i get the attribute of the user:    login.salt
    Wait Until Element Is Visible    id:email
    Input Text    id:email    ${email}
    Input Text    id:password    ${password}

i should see the contact list page
    Wait Until Element Is Visible    xpath=//h1[contains(text(), 'Contact List')]    60

i click in logout
    Wait Until Element Is Visible    id:logout
    Click Element    id:logout






# adding contacts
i click in add a new contact button
    Wait Until Element Is Visible    id:add-contact
    Click Element    id:add-contact

i see the add contact page
    Wait Until Element Is Visible    xpath=//h1[contains(text(), 'Add Contact')]

i fill up the form for adding new contacts
    [Arguments]    ${number_contacts}
    
    FOR    ${index_contact}    IN RANGE    0    ${number_contacts}
        
        i should see the contact list page
        i click in add a new contact button
        i see the add contact page

        ${first_name}=    i get the attribute a contact:     ${index_contact}    name.first
        Input Text    id:firstName    ${first_name}

        ${last_name}=    i get the attribute a contact:     ${index_contact}    name.last
        Input Text    id:lastName    ${last_name}

        ${date_birth}=    i get the attribute a contact:     ${index_contact}    dob.date
        Log    ${date_birth}[:9]
        Input Text    id:birthdate    ${date_birth}[:10]

        ${email}=    i get the attribute a contact:     ${index_contact}    email
        Input Text    id:email    ${email}

        ${phone}=    i get the attribute a contact:     ${index_contact}    phone
        ${phone_strip}=    Evaluate    "${phone}".replace('-', '').replace('/', '').replace('X', '').replace('C', '').replace('(', '').replace(')', '').replace(' ', '')
        Input Text    id:phone    ${phone_strip}

        ${street_address}=    i get the attribute a contact:     ${index_contact}    location.street.name
        Input Text    id:street1    ${street_address}

        ${street_address2}=    i get the attribute a contact:     ${index_contact}    location.street.number
        Input Text    id:street2    ${street_address2}

        ${city}=    i get the attribute a contact:     ${index_contact}    location.city
        Input Text    id:city    ${city}

        ${state}=    i get the attribute a contact:     ${index_contact}    location.state
        Input Text    id:stateProvince    ${state}

        ${postcode}=    i get the attribute a contact:     ${index_contact}    location.postcode
        Input Text    id:postalCode    ${postcode}

        ${country}=    i get the attribute a contact:     ${index_contact}    location.country
        Input Text    id:country    ${country}
        
        click submit button

    END





############## API METHODS ###################

add user
    [Arguments]    ${domain_url}    ${endpoint}    ${method}    ${body}

    ${response_new_user}=    call api    ${domain_url}    ${endpoint}    ${method}    ${body}

    Log    ${response_new_user}

    RETURN    ${response_new_user}


i login
    [Arguments]    ${domain_url}    ${endpoint}    ${method}    ${body}    ${password}

    ${email}=    Get Attribute Response    ${body}    user.email

    ${body_login}=    Evaluate    {"email": "${email}", "password": "${password}"}    json

    ${response_login}=    call api    ${domain_url}    ${endpoint}    ${method}    ${body_login}

    Log    ${response_login}

    RETURN    ${response_login}


i logout
    [Arguments]    ${domain_url}    ${endpoint}    ${method}    ${bearer}

    ${bearer_token}=    Get Attribute Response    ${bearer}    token

    ${response_logout}=    call api    ${domain_url}    ${endpoint}    ${method}    ${None}    ${bearer_token}

    RETURN    ${response_logout}

call api
    [Arguments]    ${domain_url}    ${endpoint}    ${method}    ${body}    ${bearer}=None
    
    IF    $bearer == None
        ${bearer}=    Create Dictionary    Authorization=Bearer {{token}}
    
    ELSE
        ${bearer}=    Create Dictionary    Authorization=Bearer ${bearer}   
    END
    
    Create Session    contact_list    ${URLAPP}

    
    ${mount_method}=    Catenate    ${method} On Session
    Log    ${mount_method}

    ${response}=    Run Keyword    ${mount_method}    contact_list    ${endpoint}    json=${body}    headers=${bearer}
    
    ${possible_status}=    Set Variable    '200,201'

    Log    ${response.status_code}

    ${status_string}=    Convert To String    ${response.status_code}
        
    Should Contain    ${possible_status}    ${status_string}
    
    ${content}=    Convert To String    ${response.content}
    IF    '${content}' != ''
        RETURN    ${response.json()}
    ELSE
        RETURN    vazio
    END      


i mount the body for creating a user
    ${first_name}=    And i get the attribute of the user:    name.first
    ${last_name}=    And i get the attribute of the user:    name.last
    ${email}=    And i get the attribute of the user:    email
    ${password}=    And i get the attribute of the user:    login.salt

    ${body}=    Evaluate     {"firstName": "${first_name}", "lastName": "${last_name}", "email": "${email}", "password": "${password}"}    json

    Log    ${body}
    RETURN    ${body}    ${password}

i add any number of contacts
    [Arguments]    ${number_contacts}    ${domain_url}    ${endpoint}    ${method}    ${bearer}
    
    FOR    ${index_contact}    IN RANGE    0    ${number_contacts}
        

        ${first_name}=    i get the attribute a contact:     ${index_contact}    name.first

        ${last_name}=    i get the attribute a contact:     ${index_contact}    name.last

        ${date_birth}=    i get the attribute a contact:     ${index_contact}    dob.date
        Log    ${date_birth}[:9]

        ${email}=    i get the attribute a contact:     ${index_contact}    email

        ${phone}=    i get the attribute a contact:     ${index_contact}    phone
        ${phone_strip}=    Evaluate    "${phone}".replace('-', '').replace('/', '').replace('X', '').replace('C', '').replace('(', '').replace(')', '').replace(' ', '')

        ${street_address}=    i get the attribute a contact:     ${index_contact}    location.street.name

        ${street_address2}=    i get the attribute a contact:     ${index_contact}    location.street.number

        ${city}=    i get the attribute a contact:     ${index_contact}    location.city

        ${state}=    i get the attribute a contact:     ${index_contact}    location.state

        ${postcode}=    i get the attribute a contact:     ${index_contact}    location.postcode

        ${country}=    i get the attribute a contact:     ${index_contact}    location.country

        ${body_contacts}=    Evaluate     {"firstName": "${first_name}", "lastName": "${last_name}","email": "${date_birth}[:9]" , "email": "${email}", "phone": "${phone_strip}", "street1": "${street_address}", "street2": "${street_address2}", "city": "${city}", "stateProvince": "${state}", "postalCode": "${postcode}", "country": "${postcode}"}    json
        Log    ${body_contacts}

        ${bearer_token}=    Get Attribute Response    ${bearer}    token

        ${response_addcontact}=    call api    ${domain_url}    ${endpoint}    ${method}    ${body_contacts}    ${bearer_token}

    END

    Dictionary Should Contain Sub Dictionary    ${response_addcontact}    ${body_contacts}