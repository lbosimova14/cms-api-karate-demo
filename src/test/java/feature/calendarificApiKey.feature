Feature: Calendarific  Api Test with api-key
   Background:
     * url 'https://calendarific.com/api/v2/'
     * param api_key = '8a0d07c6297962c40141e95a677b0bf7b500078e'
     Scenario: Verify that user cannot access web service without valid API key
       Given  header Content-Type = 'application/json'
       And  path 'countries'
       When  method get
       Then  status 401
       And  match response.meta.error_detail contains 'Missing or invalid api credentials.'

   Scenario: Verify that user access web service with valid API key
    Given  header Content-Type = 'application/json'
    And  path 'countries'
    When  method get
    Then  status 200
    Then match header Content-Type == 'application/json'
    And  match response.response.countries != null

   Scenario: Verify that there are 11 national holidays in the US
      Given path 'holidays'
      When  param country = 'US'
      And   param type = 'national'
      *    param year = 2019
      And method get
      Then status 200
      And match response.response.holidays == '#[11]'

#did not work
  Scenario: Verify holidays name is "New Year's Day"
    And   path 'holidays'
    When  params { country:'US', type: 'national', year: 2019}
    And method get
    Then status 200
    * def data = response.response.holidays
    * def myFun =
    """
    function(arg){
    for(i=0; i<arg.length; i++){
    if(arg[i].day == 1){
       return arg[i]
       } }
    }
    """
    * def day = call myFun data
    Then print 'day is:', day