#mock checks
Feature: TC01 api

# @C41225 @sanity
 Scenario: POSITIVE API mock check 1
   When I make a REST GET call to "/screens"
   Then The response code should be 200

# @C41227 @sanity
# Scenario: POSITIVE API mock check 2
#   When I make a REST GET call to "/version"
#   Then The response code should be 200