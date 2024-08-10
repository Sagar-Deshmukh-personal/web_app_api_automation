@sanity @pfcc
Feature: To demonstrate Unfunded API

Background:
    # Declarations and file read of headers/cookies
    * def fetchDataFromPrerequisiteFile = read('../other/prerequsite.json')
    * def getUrl = fetchDataFromPrerequisiteFile.config
    * def getHeaders = fetchDataFromPrerequisiteFile.actualHeaders

    # Declarations and file read of 'Login.json' request body
    * def getRequestBodyLogin = read('../request/requestBodyLogin.json')

    # Declarations and file read of 'Login.json' response body
    * def getResponseBodyLogin = read('../response/responseBodyLogin.json')

@pfcc
Scenario: [TC-UNF-01] Verify the fetch PF and CC detail with success response.
# Calling generate CSRF scenario from registered.feature
        * def fetchGenrateCsrfScenario = call read('ExecutionHelper/LoginAutoDDR.feature@generateautoother')
        * print fetchGenrateCsrfScenario
        * def Authorization = 'Bearer ' + fetchGenrateCsrfScenario.storedTokenValues.token

# After completion of Auth and login, call the Get API of PFCC.
        Given url getUrl.mintifiBaseUrl + getUrl.typetatchPfCc
        And headers getHeaders
        And header Authorization = Authorization

# Send the GET request
         When method get

# Verify the response status code
        Then status 200

# Print the response for debugging
        Then print "Response: ", response

# Validate the first loan application in the response list
        * def firstLoanApplication = response[0]

# Validate that pfTotalAmount is greater than or equal to pfPaidAmount
        Then assert firstLoanApplication.pfTotalAmount >= firstLoanApplication.pfPaidAmount

# Validate that pfUnpaidAmount is greater than or equal to 0
        Then assert firstLoanApplication.pfUnpaidAmount >= 0

# Validate that ccTotalAmount is greater than or equal to ccPaidAmount
        Then assert firstLoanApplication.ccTotalAmount >= firstLoanApplication.ccPaidAmount

# Validate the second loan application in the response list (if needed)
        * def secondLoanApplication = response[1]
        Then assert secondLoanApplication.pfTotalAmount >= secondLoanApplication.pfPaidAmount
        Then assert secondLoanApplication.pfUnpaidAmount >= 0
        Then assert secondLoanApplication.ccTotalAmount >= secondLoanApplication.ccPaidAmount