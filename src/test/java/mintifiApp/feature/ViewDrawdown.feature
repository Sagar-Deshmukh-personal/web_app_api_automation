@sanity @viewddr
Feature: To demonstarte all ddr for that customer api testcases 

Background:
# Declarations and file read of headers/ cookies
        * def fetchDataFromPrerequisiteFile = read('../other/prerequsite.json')
        * def getUrl = fetchDataFromPrerequisiteFile.config
        * def getHeaders = fetchDataFromPrerequisiteFile.actualHeaders
    
#Declarations and file read of 'Login.json' request body
        * def getRequestBodyLogin = read('../request/requestBodyLogin.json')
    
#Declarations and file read of 'Login.json' response body
        * def getResponseBodyLogin = read('../response/responseBodyLogin.json') 
@viewddr
Scenario: [TC-ViewDDR-01] To verify, all ddr for that customer

# calling genrate csrf secanrio from registred.feature

    * def fetchGenrateCsrfScenario = call read('ExecutionHelper/LoginApiother.feature@generateother')
    * print fetchGenrateCsrfScenario
    * karate.set('Authorization', 'Bearer ' + fetchGenrateCsrfScenario.storedTokenValues.token)

# Setting the URL for the API call
    Given url getUrl.mintifiBaseUrl + getUrl.typeViewdrawdown
# Setting the required headers for the API call
    And headers getHeaders
# Adding the Authorization header
    And header Authorization = Authorization
 # Making a GET request to the API
    When method GET
 # Validating that the response status is 200
    Then status 200
# Validate that drawdownId is a string
    * match response.drawdownViews[0].drawdownId == "#string"

# Validate the status is one of the allowed values
    * match response.drawdownViews[0].status == "#? _ == 'completed' || _ == 'pending' || _ == 'in-progress'"

# Validate loanAccountNumber matches the expected value
    * match response.drawdownViews[0].loanAccountNumber == "QA5OD66892"   

# Validate loanApplicationId matches the expected value
    * match response.drawdownViews[0].loanApplicationId == "66892"