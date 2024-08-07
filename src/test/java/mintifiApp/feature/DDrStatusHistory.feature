@ddrstatus
Feature: To demonstarte DDR Status History API

Background:
Declarations and file read of headers/ cookies
        * def fetchDataFromPrerequisiteFile = read('../other/prerequsite.json')
        * def getUrl = fetchDataFromPrerequisiteFile.config
        * def getHeaders = fetchDataFromPrerequisiteFile.actualHeaders
    
#Declarations and file read of 'Login.json' request body
        * def getRequestBodyLogin = read('../request/requestBodyLogin.json')
    
#Declarations and file read of 'Login.json' response body
        * def getResponseBodyLogin = read('../response/responseBodyLogin.json')

@ddrstatus
Scenario: [TC-DDRStatus-01] Verify the DDR Status History API response for each individual DDR ID

# calling genrate csrf secanrio from registred.feature

        * def fetchGenrateCsrfScenario = call read('ExecutionHelper/LoginAutoDDR.feature@generateautoother')
        * print fetchGenrateCsrfScenario
        * karate.set('Authorization', 'Bearer ' + fetchGenrateCsrfScenario.storedTokenValues.token)

# After completion of Auth and login then call the Get API of track ddr.
        Given url getUrl.mintifiBaseUrl + getUrl.typeDDRStatusHistory
        And headers getHeaders
        And header Authorization = Authorization
        When method GET
        Then status 200
        Then print response