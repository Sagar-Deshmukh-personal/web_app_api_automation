To run the following project on your local machine please follow below instructions:

1. Installtion - https://www.udemy.com/course/karate-dsl-api-automation-and-performance-from-zero-to-hero/learn/lecture/22174564#overview
2. Installtion prerequisite is :
    Java: Version 8 and above
    Mavan: https://maven.apache.org/download.cgi
3. Git Clone - https://github.com/Sagar-Deshmukh-personal/web_app_api_automation.git
   For understanding purpose I have kept target folder consisting of reports but in ideal use case when committing code 'target/' folder is excluded

4. Use following command in terminal:
    - mvn clean install
    - mvn test "-Dkarate.options=--tags @sanity"
5. Test reports will be generated inside folder '/target' open the same in browser to review
    - Cucumber report - /target/cucumber-html-reports/overview-features.html
    - Basic karate report - /target/karate-reports/karate-summary.html
6. The report will demonstarte table 'Scenarios' - Pass/Fail v/s the Feature and it will aslo display the same for 'No. of steps for those scenarios'
   Click on the feature file to read detailed steps and execution output

If any doubts please contact me on below details:
    - Owner: Sagar Deshmukh
    - Email: sagar.deshmukh@mintifi.com
