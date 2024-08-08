@sanity @event
Feature: To demonstarte Event Log API 

Background:
Declarations and file read of headers/ cookies
        * def fetchDataFromPrerequisiteFile = read('../other/prerequsite.json')
        * def getUrl = fetchDataFromPrerequisiteFile.config
        * def getHeaders = fetchDataFromPrerequisiteFile.actualHeaders
    
#Declarations and file read of 'Login.json' request body
        * def getRequestBodyLogin = read('../request/requestBodyLogin.json')
    
#Declarations and file read of 'Login.json' response body
        * def getResponseBodyLogin = read('../response/responseBodyLogin.json') 
@event
Scenario: [TC-EL-01] Verify that sending a valid event log request to the Event Log API returns a successful response with the correct message
# calling genrate csrf secanrio from registred.feature

        * def fetchGenrateCsrfScenario = call read('ExecutionHelper/LoginAutoDDR.feature@generateautoother')
        * print fetchGenrateCsrfScenario
        * karate.set('Authorization', 'Bearer ' + fetchGenrateCsrfScenario.storedTokenValues.token)

# After completion of Auth and login then call the Get API of track ddr.
        Given url getUrl.mintifiBaseUrl + getUrl.typeEventLog
        And headers getHeaders
        And header Authorization = Authorization
        And request getRequestBodyLogin.verifyEventLog
# Send the POST request with form data
        When method post

# Verify the response status code
        Then status 200
    
# Print the response for debugging
        Then print "Response: ", response

@event        
Scenario: [TC-EL-02] Verify that sending a in-valid event log request to the Event Log API returns a error response with the correct message
 # calling genrate csrf secanrio from registred.feature
        
        * def fetchGenrateCsrfScenario = call read('ExecutionHelper/LoginAutoDDR.feature@generateautoother')
        * print fetchGenrateCsrfScenario
        * karate.set('Authorization', 'Bearer ' + fetchGenrateCsrfScenario.storedTokenValues.token)
        
# After completion of Auth and login then call the Get API of track ddr.
        Given url getUrl.mintifiBaseUrl + getUrl.typeEventLog
        And headers getHeaders
        And header Authorization = Authorization
        And request getRequestBodyLogin.verifyinvalidEventLog         
# Send the POST request with form data
        When method post
        
# Verify the response status code
        Then status 400
            
# Print the response for debugging
        Then print "Response: ", response

@event      
Scenario: [TC-EL-03] To verify 'Fuzzy Match' for evenlt log verification for valid data
# calling genrate csrf secanrio from registred.feature
        * def fetchGenrateCsrfScenario = call read('ExecutionHelper/LoginAutoDDR.feature@generateautoother')
        * print fetchGenrateCsrfScenario
        * karate.set('Authorization', 'Bearer ' + fetchGenrateCsrfScenario.storedTokenValues.token) 
                
# After completion of Auth and login then call the Get API of track ddr.
        Given url getUrl.mintifiBaseUrl + getUrl.typeEventLog
        And headers getHeaders
        And header Authorization = Authorization
        And request getRequestBodyLogin.verifyEventLog
# Send the POST request with form data
        When method post
        
# Verify the response status code
        Then status 200
            
# Print the response for debugging
        Then print "Response: ", response
#FuzzyMatcing 
        * def expectedResponseDataTypes =
        """
        getResponseBodyLogin.verifyEventLogFuzzyMatch 
        """
        * print expectedResponseDataTypes
        * def actualResponseDataTypes = response
        * print actualResponseDataTypes
        And match actualResponseDataTypes == expectedResponseDataTypes