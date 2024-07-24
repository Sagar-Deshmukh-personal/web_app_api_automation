@sanity @paidinvoice
Feature: To demonstarte the customere Paid/Closed invoice API

Background:
#Declarations and file read of headers/ cookies
        * def fetchDataFromPrerequisiteFile = read('../other/prerequsite.json')
        * def getUrl = fetchDataFromPrerequisiteFile.config
        * def getHeaders = fetchDataFromPrerequisiteFile.actualHeaders
        * header sec-ch-ua-mobile = '?0'
        * header Accept = 'application/json, text/plain, */*'
    
#Declarations and file read of 'Login.json' request body
        * def getRequestBodyLogin = read('../request/requestBodyLogin.json')
    
#Declarations and file read of 'Login.json' response body
        * def getResponseBodyLogin = read('../response/responseBodyLogin.json') 

@paidinvoice
Scenario: [TC-CI-01] To verify the closed Invoice API without any query Parameter


# calling genrate csrf scenario from registred.feature
        * def fetchGenrateCsrfScenario = call read('ExecutionHelper/Loginticket.feature@generateLoginToken')
        * print fetchGenrateCsrfScenario
        * karate.set('Authorization', 'Bearer ' + fetchGenrateCsrfScenario.storedLoginTokenValues.token)
        
# After completion of Auth and login then call the Get API of  customer profile.
        Given url getUrl.mintifiBaseUrl + getUrl.typeAuthCheckPaidInvoice
        And headers getHeaders
        And header Authorization = Authorization
        When method GET
        Then status 200

# Capture the initial value of totalElements
        * def initialTotalElements = response.totalElements
        * print 'Initial total elements: ', initialTotalElements

# Validate specific fields in the response content array
        * def content = response.content[0]  // Get the first item in the content array
        * match content.invoiceId == '#string'
        * match content.apInvoiceId == '#string'
        * match content.loanApplicationId == '#string'
        * match content.invoiceNumber == '#string'
        * match content.invoiceDate == '#string'
        * match content.invoiceDueDate == '#string'
        * match content.invoiceAmount == '#string'
        * match content.paidAmount == '#string'
        * match content.unpaidAmount == '#string'
        * match content.companyId == '#string'
        * match content.fundStatus == '#boolean'
# Display a message indicating that the response matches the expected structure
        * def responseMatches = true
        * karate.log('Response matches the expected structure.')

@paidinvoice @text
Scenario: [TC-CI-02] To verify the closed Invoice API with query Parameter

# calling genrate csrf scenario from registred.feature
         * def fetchGenrateCsrfScenario = call read('ExecutionHelper/Loginticket.feature@generateLoginToken')
         * print fetchGenrateCsrfScenario
         * karate.set('Authorization', 'Bearer ' + fetchGenrateCsrfScenario.storedLoginTokenValues.token)
                    
# After completion of Auth and login then call the Get API of  customer profile.
         * def baseUrl = getUrl.mintifiBaseUrl + getUrl.typeAuthCheckPaidInvoice
         * def queryString = 'size=10&page=1'
         * def fullUrl = baseUrl + (baseUrl.includes('?') ? '&' : '?') + queryString
           Given url fullUrl
           And headers getHeaders
           And header Authorization = Authorization
           When method GET
           Then status 200
           Then print "Response: ", response