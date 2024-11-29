@intiateorder
Feature: To demonstarte Intiate payment order API
Background:
# Declarations and file read of headers/ cookies
        * def fetchDataFromPrerequisiteFile = read('../other/prerequsite.json')
        * def getUrl = fetchDataFromPrerequisiteFile.config
        * def getHeaders = fetchDataFromPrerequisiteFile.actualHeaders
    
#Declarations and file read of 'Login.json' request body
        * def getRequestBodyLogin = read('../request/requestBodyLogin.json')
    
#Declarations and file read of 'Login.json' response body
        * def getResponseBodyLogin = read('../response/responseBodyLogin.json') 

@intiateorder
Scenario: [TC-intiatepayment-01] To verify Intiate payment order API.

# calling genrate csrf secanrio from registred.feature

        * def fetchGenrateCsrfScenario = call read('ExecutionHelper/LoginApiother.feature@generateother')
        * print fetchGenrateCsrfScenario
        * karate.set('Authorization', 'Bearer ' + fetchGenrateCsrfScenario.storedTokenValues.token)

# Setting the URL for the API call
        Given url getUrl.mintifiBaseUrl + getUrl.typeInitiatOrder
# Setting the required headers for the API call
        And headers getHeaders
# Adding the Authorization header
        And header Authorization = Authorization
# Setting the required request body
        * def requestBody = getRequestBodyLogin.verifyIntiateOrder
        * request requestBody
        Then print requestBody
# Making a GET request to the API
        When method post
# Validating that the response status is 200
        Then status 200
# Printing the response for debugging
        Then print response

# Validate paymentGateway is CCAvenue
        * match response.paymentGateway == "CCAvenue"
# Validate and log using Karate's conditional logic
        * if (response.paymentGateway == 'CCAvenue') karate.log('✅ Payment gateway is correctly set to CCAvenue: ' + response.paymentGateway)
        * if (response.paymentGateway != 'CCAvenue') karate.fail('❌ Payment gateway is not CCAvenue')
