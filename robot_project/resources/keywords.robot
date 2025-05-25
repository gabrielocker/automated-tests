*** Settings ***
Library    SeleniumLibrary
Library    random_user.py


*** Keywords ***

# creating random user or contact
i create a random user
    Instance Randomuser
    ${users}=    Generate Users    1

i create any number of random contacts:
    [Arguments]    ${contacts}
    Instance Randomuser
    ${users}=    Generate Users    ${contacts}

i get the attribute of the user:
    [Arguments]    ${requested_argument}
    ${attribute}    Get Attribute    0    ${requested_argument}
    RETURN    ${attribute}




# navigation
click sign up button
    Wait Until Element Is Visible    id:signup
    Click Element    id:signup

see the add user page
    Wait Until Element Is Visible    xpath=//h1[contains(text(), 'Add User')]

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
    Open Browser    https://thinking-tester-contact-list.herokuapp.com    chrome
    Sleep    1s

i input a email and password
    ${email}=    And i get the attribute of the user:    email
    ${password}=    And i get the attribute of the user:    login.salt
    Wait Until Element Is Visible    id:email
    Input Text    id:email    ${email}
    Input Text    id:password    ${password}

i should see the contact list page
    Wait Until Element Is Visible    xpath=//h1[contains(text(), 'Contact List')]

i click in logout
    Wait Until Element Is Visible    id:logout
    Click Element    id:logout



# adding contacts
i click in add a new contact button
    Wait Until Element Is Visible    id:add-contact
    Click Element    id:add-contact

i see the add contact page
    Wait Until Element Is Visible    xpath=//h1[contains(text(), 'Add Contact')]

i fill up the form for adding a new contact
    ${first_name}=    And i get the attribute of the user:    name.first
    Input Text    id:firstName    ${first_name}

    ${last_name}=    And i get the attribute of the user:    name.last
    Input Text    id:lastName    ${last_name}

    ${date_birth}=    And i get the attribute of the user:    dob.date
    Log    ${date_birth}[:9]
    Input Text    id:birthdate    ${date_birth}[:10]

    ${email}=    And i get the attribute of the user:    email
    Input Text    id:email    ${email}

    ${phone}=    And i get the attribute of the user:    phone
    ${phone_strip}=    Evaluate    re.sub(r'\D', '', '''${phone}''')    re
    Input Text    id:phone    ${phone_strip}

    ${street_address}=    And i get the attribute of the user:    location.street.name
    Input Text    id:street1    ${street_address}

    ${street_address2}=    And i get the attribute of the user:    location.street.number
    Input Text    id:street2    ${street_address2}

    ${city}=    And i get the attribute of the user:    location.city
    Input Text    id:city    ${city}

    ${state}=    And i get the attribute of the user:    location.state
    Input Text    id:stateProvince    ${state}

    ${postcode}=    And i get the attribute of the user:    location.postcode
    Input Text    id:postalCode    ${postcode}

    ${country}=    And i get the attribute of the user:    location.country
    Input Text    id:country    ${country}