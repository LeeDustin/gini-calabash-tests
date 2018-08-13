@accounts
Feature: accounts page
# set app to English first and linked banks already, all cards selected, shows Select all

Background:
    Given the app has launched
    And I wait for Continue for 10 seconds
    And I wait for 1 second
#    And I select Skip/跳過
    And I enter 333333 as passcode
    When I select Continue
    Then I should see Transaction Feed/最新動態
    And I select Accounts
    And I should see Cash Balance



Scenario: select card
    Given there should be 0 cards unselected

    When I select Select All
    Then there should be 0 cards unselected
    And I should see Select none

    When I wait for 1 second
    And I select Select none
#    And I select Select none
    Then there should be 3 cards unselected
    And I should see Select All

    When I select Select All
    And I should see Select none
    And I select Dummy Account 08 8888 8888 88
    Then there should be 2 cards unselected

    When I select Liability Two 1111 1111 13
    Then there should be 1 card unselected

    When I select Dummy Account 08 8888 8888 88
    Then there should be 2 cards unselected

    And I select Select All


Scenario: cash accounts on card
    When there should be 0 cards unselected
    Then I should see Demobank 2

    When I select Dummy Account 08 8888 8888 88
    Then I should not see Demobank 2

    When I select Select All
    Then I should see Demobank 2


Scenario: cash accounts collapse and see all
    When I select Cash Accounts
    And I select Cash Accounts
    Then I should see Demobank 2

    When I select See all
    Then I should see See less
    And I select See less






