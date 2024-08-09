@sanity @advpayment
Feature: To demonstart Advance-Payment API

Background:
Declarations and file read of headers/ cookies
        * def fetchDataFromPrerequisiteFile = read('../other/prerequsite.json')
        * def getUrl = fetchDataFromPrerequisiteFile.config
        * def getHeaders = fetchDataFromPrerequisiteFile.actualHeaders
    
#Declarations and file read of 'Login.json' request body
        * def getRequestBodyLogin = read('../request/requestBodyLogin.json')
    
#Declarations and file read of 'Login.json' response body
        * def getResponseBodyLogin = read('../response/responseBodyLogin.json') 
@advpayment
Scenario: [TC-ADP-01] Verify the advance payment api with success response.
# calling genrate csrf secanrio from registred.feature

        * def fetchGenrateCsrfScenario = call read('ExecutionHelper/LoginAutoDDR.feature@generateautoother')
        * print fetchGenrateCsrfScenario
        * karate.set('Authorization', 'Bearer ' + fetchGenrateCsrfScenario.storedTokenValues.token)

# After completion of Auth and login then call the Get API of Advance Payment.
        Given url getUrl.mintifiBaseUrl + getUrl.typeAdvancePayment
        And headers getHeaders
        And header Authorization = Authorization
# Send the get request with form data
        When method get

# Verify the response status code
        Then status 200
# Print the response for debugging
        Then print "Response: ", response
# Validate the structure and content of the response
        * def expectedResponseStructure = 
        """
        {
            "loanApplicationId": "#string",
            "anchorId": "#string",
            "anchorName": "#string",
            "anchorUrl": "#null"
        }
        """
        * match each response == expectedResponseStructure