@tsearch
Feature: transaction search (not working)
# set app to English first and linked banks already
# view can still be seen even filtered out
# Housing and Utilities categories labeled as Uncategorized

Background:
    Given the app has launched
    And I wait for Continue for 10 seconds
    And I wait for 4 seconds
#    And I select Skip/跳過
    And I enter 333333 as passcode
    When I select Continue
    Then I should see Transaction Feed/最新動態
    And I click back
# search button

Scenario: check uncategorized search bug
When I select Category
And I select Uncategorized
Then I wait for Morton's: The Steakhouse for 10 seconds
And I wait for 10 seconds
And I should not see ATM Withdrawal
And I wait for 10 seconds

Scenario Outline: filter category
    When I select Category
    And I select <category>
    Then I wait for <transaction> for 10 seconds

Examples:
    |category|transaction|
    |All|ATM Withdrawal|
    |Income|Payroll|
    |Eating out|EW Food Hall|
    |Uncategorized|Morton\\'s: The Steakhouse|

Scenario: check uncategorized search bug
    When I select Category
    And I select Uncategorized
    Then I wait for Morton\\'s: The Steakhouse for 10 seconds
    And I should not see ATM Withdrawal

Scenario: Select Date Range
    When I select Period
    And I swipe down 1 time normal
    And I swipe down 1 time light
# go to July calendar

    And I select 11
    And I select 12
    And I select Select Date Range

    Then I should see 11th Jul to 12th Jul
    And I wait for ATM Withdrawal for 10 seconds




