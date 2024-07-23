@sanity @customer
Feature: To demonstarte Customer api testcases 

Background:
    Declarations and file read of headers/ cookies
        * def fetchDataFromPrerequisiteFile = read('../other/prerequsite.json')
        * def getUrl = fetchDataFromPrerequisiteFile.config
        * def getHeaders = fetchDataFromPrerequisiteFile.actualHeaders
    
    #Declarations and file read of 'Login.json' request body
    * def getRequestBodyLogin = read('../request/requestBodyLogin.json')
    
    #Declarations and file read of 'Login.json' response body
    * def getResponseBodyLogin = read('../response/responseBodyLogin.json') 
@customer
Scenario: [TC-customer-01] To verify the customer API

# calling genrate csrf secanrio from registred.feature

    * def fetchGenrateCsrfScenario = call read('ExecutionHelper/Loginticket.feature@generateLoginToken')
    * print fetchGenrateCsrfScenario
    * karate.set('Authorization', 'Bearer ' + fetchGenrateCsrfScenario.storedLoginTokenValues.token)

     Given url getUrl.mintifiBaseUrl + getUrl.typeAuthCustomer
     And headers getHeaders
     And header Authorization = Authorization

#Send the GET request with form data
     When method GET
 
# Verify the response status code
     Then status 200
 
# Print the response for debugging
     Then print "Response: ", response

# Check details in the loans array
     * def loans = response.loans

# Extract and print customer details and its values
     * def custId = response.custId
     * print 'Customer Id:', custId
     * def customerName = response.customerName
     * print 'Customer Name:' , customerName
     * def emailId = response.emailId
     * print 'Customer Email Id:', emailId
     * def phone = response.phone
     * print 'Customer Phone No"', phone
     * def totalAvailableLimit = response.totalAvailableLimit
     * print 'Total Available Limit: ', totalAvailableLimit
     * def totalDues = response.totalDues
     * print 'Total Dues:', totalDues
     * def totalLimit = response.totalLimit
     * print 'Total Limit:', totalLimit

# Function to print loan details
     * def LoanAndApplicationDetails = 
    """
    function(loan) {
      karate.log('Loan Account Number:', loan.loanAccountNumber);
      karate.log('Loan Application Id:', loan.loanApplicationId);
      karate.log('Type:', loan.type);
      karate.log('Status:', loan.status);
      karate.log('Anchor Name:', loan.anchorName);
      karate.log('Company Name:', loan.companyName);
      karate.log('Limit:', loan.limit);
      karate.log('Available Limit:', loan.availableLimit);
      karate.log('Total Outstanding:', loan.totalOutstanding);
      karate.log('Utilized Limit:', loan.utilizedLimit);
      karate.log('Agreement Type:', loan.agreementType);
      karate.log('Total Principal Outstanding:', loan.totalPrincipalOutstanding);
      karate.log('Total Interest Outstanding:', loan.totalInterestOutstanding);
      karate.log('Total Penal Outstanding:', loan.totalPenalOutstanding);
      karate.log('Total Principal Overdue:', loan.totalPrincipalOverdue);
      karate.log('Total Interest Overdue:', loan.totalInterestOverdue);
      karate.log('Total Overdue:', loan.totalOverdue);
      karate.log('EMI Amount:', loan.emiAmount);
      karate.log('Number Of EMIs Paid:', loan.numberOfEmisPaid);
      karate.log('Tenure:', loan.tenure);
      karate.log('Lender Id:', loan.lenderId);
      karate.log('Payment Allowed:', loan.paymentAllowed);
      karate.log('DPD Interest:', loan.dpdInterest);
      karate.log('DPD Principal:', loan.dpdPrincipal);
      karate.log('DPD:', loan.dpd);
      karate.log('PF Amount:', loan.pfAmount);
      karate.log('PF Amount Paid:', loan.pfAmountPaid);
      karate.log('CC Amount:', loan.ccAmount);
      karate.log('CC Amount Paid:', loan.ccAmountPaid);
      karate.log('Expiry Date:', loan.expiryDate);
      karate.log('Applications:', loan.applications);
    }
    """
# Iterate through each loan and print its details using the function
    * karate.forEach(loans, LoanAndApplicationDetails)
    * print 'All loans details printed successfully.'