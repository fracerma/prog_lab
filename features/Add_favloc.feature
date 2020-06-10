Feature: User can add location to favourites locations
 
    Scenario: Add loc to favloc
        Given a valid user
        When I am on the login page
        And I fill in "user_email" with "test@hotmail.com"
        And I fill in "user_password" with "Tester12!"
        And I press "Login"
        Then I should be on the home page

        Given a valid location
        When I am on the location page

        And I follow "Add to favourites locations"
        Then I should be on the index favloc page
        And I should see "testloc"
   
        

