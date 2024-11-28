@generateother
Feature: To demonstarte store and feed resposne data of a request in other feature file and request as a pre-requisite
# We have NOT added @sanity annotation for the feature file as this will only act as feeded for other request and we do not want the same in cucumber report 

Background:
    #Declarations and file read of headers/ cookies
        * def fetchDataFromPrerequisiteFile = read('../other/prerequsite.json')
        * def getUrl = fetchDataFromPrerequisiteFile.config
        * def getHeaders = fetchDataFromPrerequisiteFile.actualHeaders
    
    #Declarations and file read of 'Login.json' request body
        * def getRequestBodyLogin = read('../request/requestBodyLogin.json')
    
@generateother
Scenario: To verify 'Login with Cust id" with using Mpin
        Given url getUrl.mintifiBaseUrl + getUrl.typeAuthSendOtpAPI
        * headers getHeaders
        And request getRequestBodyLogin.verifyloginother
        When method post
        Then status 200
        And print response
        * def storedRequestidValues = response.requestId
        * print storedRequestidValues

        Given url getUrl.mintifiBaseUrl + getUrl.typeAuthVerifyOtpAPI
        * headers getHeaders
        * def requestBody = getRequestBodyLogin.verifyOtpother
        * requestBody.requestId = storedRequestidValues
        * request requestBody
        Then print requestBody
        When method post
        Then print response
        And assert responseStatus == 200
        
        * fetchDataFromPrerequisiteFile.actualToken.token = response.token
        * fetchDataFromPrerequisiteFile.actualToken.refreshToken = response.refreshToken
    
        * def storedTokenValues = fetchDataFromPrerequisiteFile.actualToken
        * print storedTokenValues