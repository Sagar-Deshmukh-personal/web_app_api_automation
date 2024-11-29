@sanity @custconfig
Feature: To demonstarte customer configuration API
Background:
# Declarations and file read of headers/ cookies
        * def fetchDataFromPrerequisiteFile = read('../other/prerequsite.json')
        * def getUrl = fetchDataFromPrerequisiteFile.config
        * def getHeaders = fetchDataFromPrerequisiteFile.actualHeaders
    
#Declarations and file read of 'Login.json' request body
        * def getRequestBodyLogin = read('../request/requestBodyLogin.json')
    
#Declarations and file read of 'Login.json' response body
        * def getResponseBodyLogin = read('../response/responseBodyLogin.json') 

@custconfig
Scenario: [TC-custconfig-01] To verify customer configuration API.

# calling genrate csrf secanrio from registred.feature

        * def fetchGenrateCsrfScenario = call read('ExecutionHelper/LoginApiother.feature@generateother')
        * print fetchGenrateCsrfScenario
        * karate.set('Authorization', 'Bearer ' + fetchGenrateCsrfScenario.storedTokenValues.token)

# Setting the URL for the API call
        Given url getUrl.mintifiBaseUrl + getUrl.typeCustomerConfig
# Setting the required headers for the API call
        And headers getHeaders
# Adding the Authorization header
        And header Authorization = Authorization
# Making a GET request to the API
        When method GET
# Validating that the response status is 200
        Then status 200
# Printing the response for debugging
        Then print response
# Validate notificationCount is a valid number and greater than 0
        * match response.notificationCount == "#number"
        * assert response.notificationCount > 0

# Validate advancePayment is either true or false
        * match response.advancePayment == "#boolean"

# Validate preferredLanguage is one of the allowed values
        * def allowedLanguages = ['en', 'hi-IN', 'hinglish', 'te-IN', 'ta-IN', 'ka-IN']
        * assert allowedLanguages.indexOf(response.preferredLanguage) > -1

# Optional: Log validation success messages
        * karate.log('✅ notificationCount is valid and greater than 0: ' + response.notificationCount)
        * karate.log('✅ advancePayment is valid: ' + response.advancePayment)
        * karate.log('✅ preferredLanguage is valid: ' + response.preferredLanguage)