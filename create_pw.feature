@createpw
Feature: create pw and confirm new pw

Background:
    Given I select Skip/跳過
    And I select Add bank
    And I wait for Create new passcode for 20 seconds

# set app to English first


Scenario Outline: enter pw and go to confirm new pw
    Given I enter <pw> as passcode
    And I wait for Continue for 2 seconds
    When I select Continue
    Then I should see Confirm passcode

Examples:
    |pw|
    |333333|
    |123456|

Scenario: check back button and changing passcode
    Given I enter 333332 as passcode
    And I wait for Continue for 2 seconds
    When I select Continue
    Then I should see Confirm passcode

    When I click back
    And I enter 333333 as passcode
    And I wait for Continue for 2 seconds
    Then I select Continue
    And I should see Confirm passcode

Scenario: check incorrect and correct passcode

    Given I enter 333333 as passcode
    And I wait for Continue for 2 seconds
    When I select Continue
    Then I should see Confirm passcode

    Given I enter 333332 as passcode
    And I wait for Continue for 2 seconds
    When I select Continue
    Then I select Try again

    Given I enter 333333 as passcode
    And I wait for Continue for 2 seconds
    When I select Continue
    And I select Continue
    Then I should see Bank Accounts




