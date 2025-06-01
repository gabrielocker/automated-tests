*** Variables ***


${HEADERS}    {'Authorization: Bearer {{token}}'}
${URLAPP}    https://thinking-tester-contact-list.herokuapp.com


#ENDPOINTS API
${ENDPOINT_ADD_USER}    /users
${ENDPOINT_LOGIN}    /users/login
${ENDPOINT_LOGOUT}    /users/logout
${ENDPOINT_ADD_CONTACT}    /contacts