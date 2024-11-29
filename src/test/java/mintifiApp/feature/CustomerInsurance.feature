@sanity @custinsurance
Feature: To demonstarte customer Insurance API
Background:
# Declarations and file read of headers/ cookies
        * def fetchDataFromPrerequisiteFile = read('../other/prerequsite.json')
        * def getUrl = fetchDataFromPrerequisiteFile.config
        * def getHeaders = fetchDataFromPrerequisiteFile.actualHeaders
    
#Declarations and file read of 'Login.json' request body
        * def getRequestBodyLogin = read('../request/requestBodyLogin.json')
    
#Declarations and file read of 'Login.json' response body
        * def getResponseBodyLogin = read('../response/responseBodyLogin.json') 

@custinsurance
Scenario: [TC-custconfig-01] To verify customer Insurance API.

# calling genrate csrf secanrio from registred.feature

        * def fetchGenrateCsrfScenario = call read('ExecutionHelper/LoginApiother.feature@generateother')
        * print fetchGenrateCsrfScenario
        * karate.set('Authorization', 'Bearer ' + fetchGenrateCsrfScenario.storedTokenValues.token)

# Setting the URL for the API call
        Given url getUrl.mintifiBaseUrl + getUrl.typeCustomerInsurance
# Setting the required headers for the API call
        And headers getHeaders
# Adding the Authorization header
        And header Authorization = Authorization
# Making a GET request to the API
        When method GET
# Validating that the response status is 200
        Then status 200
# Check if policyNumber is a number or null
        * match response.policyNumber == "#? _ == null || typeof _ == 'number' || /^[a-zA-Z0-9]+$/.test(_)"
        * karate.log('✅ policyNumber is valid (null, number, or alphanumeric): ' + response.policyNumber)
# Check if policyStatus is 'active' or null
        * match response.policyStatus == "#? _ == null || _ == '' || /^active$/i.test(_)"
        * karate.log('✅ policyStatus is valid (null, empty, or "active" case-insensitive): ' + response.policyStatus)