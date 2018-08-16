@reports
Feature: reports page
# set app to English first and linked banks already, reports page in July

Background:
    Given the app has launched
    And I wait for Continue for 10 seconds
    And I wait for 4 seconds
#    And I select Skip/跳過
    And I enter 333333 as passcode
    When I select Continue
    Then I should see Transaction Feed/最新動態
    And I select Report
    And I should see Jul 2018 Expenses



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


Scenario: month swapping
    When I select June
    Then I should see Jun 2018 Expenses
    And I should see May

    When I select July
    And I select August
    Then I should not see Sept
    And I should not see June

    And I select July


Scenario: Monthly spend drag
    Given I should see 31st
    When I off-center swipe left 1 time normal
    Then I should see $400
    And I should see $200


Scenario: Category Spend
    When I swipe up 2 times normal
    And I swipe down 1 time light
    Then I should see Category spend

    When I select Internal Transfer $ 999
    Then the pie slice labeled Internal Transfer $ 999 should be unselected

    When I select Payments $ 400
    Then the pie slice labeled Payments $ 400 should be unselected
    And I should see Choose the categories you want to see


Scenario: check if Biggest spend and Most visited change with month
    When I select June
    And I swipe up 1 time
    Then I should see Test

    When I wait for 2 seconds
    When I select July
    Then I should see Nike

Scenario: check drop down menu collapse and expand
    When I select Monthly spend
#    Then I should not see 31st
    And I should see Category spend

    When I select Category spend
    Then I should see Biggest spend
    And I should see Nike

    When I select Biggest spend
    Then I should see 1times
    And I should see Most visited

    When I select Most visited
    Then I should see Cash flow

    When I select Cash flow
    When I select Cash flow
    Then I should see $16K

    When I select Most visited
    Then I should see Nike

    When I select Biggest spend
    Then I should see New merchant

    When I select Category spend
    Then I should see Internal Transfer $ 999

    When I select Monthly spend
    Then I should see 31st









