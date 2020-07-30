Feature: Data driven test
  Background:
    * url 'http://dummy.restapiexample.com/api/v1/'

  Scenario Outline: Create user details
    Given path 'create'
    And request { 'name': <name>, 'salary': <salary>, 'age': <age>}
    When method post
    Then status 200
    And match response contains {status: 'success'}
    * def result = response

#    # validate auto generated id
    Given path 'employee/' + result.data.id
    And method get
    Then status 200
    And match response.data contains {id:'#(result.data.id)'}

    Examples:
    |name  | salary|age|
    |myName| 20    | 45|