@sanity @pfcc
Feature: To demonstart Unfunded API

Background:
Declarations and file read of headers/ cookies
        * def fetchDataFromPrerequisiteFile = read('../other/prerequsite.json')
        * def getUrl = fetchDataFromPrerequisiteFile.config
        * def getHeaders = fetchDataFromPrerequisiteFile.actualHeaders
    
#Declarations and file read of 'Login.json' request body
        * def getRequestBodyLogin = read('../request/requestBodyLogin.json')
    
#Declarations and file read of 'Login.json' response body
        * def getResponseBodyLogin = read('../response/responseBodyLogin.json')

@pfcc
Scenario: [TC-UNF-01] Verify the fetch PF and CC detail with success response.
# calling genrate csrf secanrio from registred.feature

        * def fetchGenrateCsrfScenario = call read('ExecutionHelper/LoginAutoDDR.feature@generateautoother')
        * print fetchGenrateCsrfScenario
        * karate.set('Authorization', 'Bearer ' + fetchGenrateCsrfScenario.storedTokenValues.token)

# After completion of Auth and login then call the Get API of PFCC.
        Given url getUrl.mintifiBaseUrl + getUrl.typetatchPfCc
        And headers getHeaders
        And header Authorization = Authorization
# Send the get request with form data
        When method get

# Verify the response status code
        Then status 200
# Print the response for debugging
        Then print "Response: ", response