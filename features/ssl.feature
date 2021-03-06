Feature: Service Should Access Basic Resources via SSL using a self-signed certificate
  
Background:
  Given an ODataService exists with uri: "https://localhost:44300/SampleService/BasicAuth/Entities.svc" using self-signed certificate and username "admin" and password "passwd"
  And blueprints exist for the service

Scenario: Service should respond to valid collections
  Then I should be able to call "Products" on the service

Scenario: Entity should fill values on protected resource
  Given I call "AddToCategories" on the service with a new "Category" object with Name: "Auth Test Category"
  And I save changes
  And I call "Categories" on the service with args: "1"
  When I run the query
  Then the method "Id" on the result should equal: "1"
  And the method "Name" on the result should equal: "Auth Test Category"

Scenario: Should get SSL failure if SSL used with self-signed certificate and not passing "false" as :verify_ssl option
  Given an ODataService exists with uri: "https://localhost:44300/SampleService/Entities.svc" it should throw an exception with message containing "SSL Verification failed"


