Feature: Test Meta Weather Karate test

  Background:
    * url 'https://www.metaweather.com/api/location'
    * def expectedOutput = read('../test_data/test.json')
    * def callFeature2 = call read('metaweather2.feature')


  Scenario: Compare whole json from internal file
    Given path '/search'
    And param query = 'New'
    When method get
    Then status 200
    * match response == expectedOutput
    And match response[1] contains {title: 'New Delhi'}
    And match each response contains {location_type: 'City'}
    #checking field is present there
    * match response[0].woeid != null
    * def unknownField = response[0].zipcode
    * match unknownField == null
    # calling data from another feature file
    * def title = callFeature2.response.sources[0].title
    Then print 'title value is: ', title

  Scenario: User verifies 3rd object contains Long Beach
    Given path '/search'
    And param query = 'Lon'
    When method get
    Then status 200
    And match response[2] contains {title: 'Long Beach'}

  Scenario: Search for London
    Given path '/search'
    And param query = 'London'
    When method get
    Then status 200
#      verify that first Json object from the payload contains title:'London'
    And match response[0] contains {title:'London'}
#      Verify that every object in the payload contains title:'London'
    And match each response contains {title:'London'}


  Scenario Outline: Verify that by query <query> every title contains <query>
    Given path '/search'
    And param query = '<query>'
    When method get
    Then status 200
    And match each response contains {title: '<query>'}

    Examples: queries
      | query       |
      | London      |
      | Los Angeles |
      | New York    |

  @ignore
  Scenario: Verify that every item in payload has location_type City
    Given path '/search'
    And param query = 'Las'
    When method get
    Then status 200
    And match each response contains {location_type: 'City'}












