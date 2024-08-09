@sanity @unfunded
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

@unfunded
Scenario: [TC-UNF-01] Verify the unfunded api with success response.
# calling genrate csrf secanrio from registred.feature

        * def fetchGenrateCsrfScenario = call read('ExecutionHelper/LoginAutoDDR.feature@generateautoother')
        * print fetchGenrateCsrfScenario
        * karate.set('Authorization', 'Bearer ' + fetchGenrateCsrfScenario.storedTokenValues.token)

# After completion of Auth and login then call the Get API of Unfunded Invoices Detail.
        Given url getUrl.mintifiBaseUrl + getUrl.typeUnfundedInvoice
        And headers getHeaders
        And header Authorization = Authorization
# Send the get request with form data
        When method get

# Verify the response status code
        Then status 200
# Print the response for debugging
        Then print "Response: ", response
# Extract totalInvoiceDues
        * def totalInvoiceDues = response.totalInvoiceDues
        * print 'Total Invoice Dues: ', totalInvoiceDues

# Validate the structure of the invoices array
        * def expectedInvoiceStructure = 
        """
        {
        "invoiceId": "#string",
        "apInvoiceId": "#string",
        "loanApplicationId": "#string",
        "invoiceNumber": "#string",
        "invoiceDate": "#string",
        "invoiceDueDate": "#string",
        "invoiceAmount": "#string",
        "paidAmount": "#string",
        "unpaidAmount": "#string",
        "companyId": "#string",
        "fundStatus": "#boolean"
        }
        """

# Validate the structure of the first anchor's invoices array
        * match each response.invoices[0].invoices == expectedInvoiceStructure

# Validate the structure of the second anchor's invoices array
        * match each response.invoices[1].invoices == expectedInvoiceStructure