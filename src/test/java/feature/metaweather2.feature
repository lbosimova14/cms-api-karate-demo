
Feature: Test2 Meta Weather Karate test
  Background:
    * url 'https://www.metaweather.com/api/location'
    * header Content-Type = 'application/json'

  @location
  Scenario: Verify following that payload contains weather forecast sources
    # 'location/', '44418/' slush sign / no needed,takes care of URL-encoding and appending '/' where needed.
    Given path 'location', '44418'
    When method get
    Then status 200