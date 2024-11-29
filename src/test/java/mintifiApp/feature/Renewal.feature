@sanity @renewal
Feature: To demonstarte customer renewal API
Background:
# Declarations and file read of headers/ cookies
        * def fetchDataFromPrerequisiteFile = read('../other/prerequsite.json')
        * def getUrl = fetchDataFromPrerequisiteFile.config
        * def getHeaders = fetchDataFromPrerequisiteFile.actualHeaders
    
#Declarations and file read of 'Login.json' request body
        * def getRequestBodyLogin = read('../request/requestBodyLogin.json')
    
#Declarations and file read of 'Login.json' response body
        * def getResponseBodyLogin = read('../response/responseBodyLogin.json') 

@renewal
Scenario: [TC-custrenewal-01] To verify customer renewal API.

# calling genrate csrf secanrio from registred.feature

        * def fetchGenrateCsrfScenario = call read('ExecutionHelper/LoginApiother.feature@generateother')
        * print fetchGenrateCsrfScenario
        * karate.set('Authorization', 'Bearer ' + fetchGenrateCsrfScenario.storedTokenValues.token)

# Setting the URL for the API call
        Given url getUrl.mintifiBaseUrl + getUrl.typerenewal
# Setting the required headers for the API call
        And headers getHeaders
# Adding the Authorization header
        And header Authorization = Authorization
# Making a GET request to the API
        When method GET
# Validating that the response status is 200
        Then status 200