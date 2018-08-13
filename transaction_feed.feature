@tfeed
Feature: transaction feed
# set app to English first and linked banks already
# 3 cards, including Liability Two, Dummy Account 08, HK 01 Cash Account, last one contains transactions, initially all selected


Background:
    Given the app has launched
    And I wait for Continue for 10 seconds
    And I wait for 1 second
#    And I select Skip/跳過
    And I enter 333333 as passcode
    When I select Continue
    Then I should see Transaction Feed/最新動態

Scenario: changing category
    When I swipe up 1 time
    Then I should see Test

    Given I wait for 3 seconds
    When I select Test
    Then I wait for The Salisbury Ymca of Hong Kong for 5 seconds

#    When I touch on screen 100 from the left and 400 from the top
    When I wait for 2 seconds
    When I select Housing
    And I wait for 2 seconds
    Then I should see Transport
    And I select Investments
    And I wait for 2 seconds
    And I should see Investments

    When I select Close
    Then I should see Transaction Feed
    And I should see Investments

Scenario: checking history (categorized)
    When I swipe up 1 time
    Then I should see Test

    When I select Test
    Then I wait for The Salisbury Ymca of Hong Kong for 5 seconds

    When I select History
    Then I should see $-1,800


Scenario: checking history (uncategorized bug)
    When I swipe up 2 times
    Then I should see Uncategorized

    When I select Uncategorized
    And I select History
    Then I should not see 0


Scenario: change to existing merchant
    When I swipe up 1 time
    Then I should see Test


    When I select Test
    Then I wait for The Salisbury Ymca of Hong Kong for 5 seconds

    When I touch on screen 100 from the left and 255 from the top
# search button
    Then I should see Search for your merchant

    When I enter "Tes" into textbox number 1
    Then I should see Tesla Motors
    And I select Tesla Motors
    And I should see Transport


Scenario: add new merchant
    When I swipe up 1 time
    Then I should see Tesla Motors

    When I select Tesla Motors
    Then I wait for The Salisbury Ymca of Hong Kong for 5 seconds

    When I touch on screen 255 from the left and 255 from the top
    Then I should see Search for your merchant

    When I select Don't see what you're looking for? Add your own
    Then I should see OK
    And the submit button labeled OK should be unclickable

    When I enter "Test1" into textbox number 1
    Then the submit button labeled OK should be clickable
    And I select OK
    And I should see Groceries

    When I select Groceries
    Then I should see SKIP
    And I select SKIP
    And I wait for Groceries for 10 seconds




Scenario: select card
    Given I wait for Are you missing any transactions or accounts? for 5 seconds
    And there should be 0 cards unselected

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

    When I select Liability Two 1111 1111 13
    And I select Liability Two 1111 1111 13
    Then I should see Nike

    When I select Dummy Account 08 8888 8888 88
    Then there should be 2 cards unselected

Scenario: Add cards and renaming cards
    When I select +
    Then I should see Bank Accounts

    And I wait for 1 second
    When I select Demobank 2
    Then I should see Name your cards

    When I swipe up 1 time
    Then I should see Liability Two

    When I select Liability Two
    And I enter "Dummy Account lol" into textbox number 1

    When I toggle button number 1
#    And I toggle button number 1

    When I click back
    And I click back
    And I select Select All
    And I select Select none
    Then there should be 4 cards unselected
    And I should see Dummy Account lol 2222 2222 22

Scenario: revert to original condition
    When I touch on screen 400 from the left and 25 from the top
# + button
    Then I should see Bank Accounts

    When I select Demobank 2
    Then I should see Name your cards

    When I swipe up 1 time
    Then I should see Liability Two
    And I select Liability Two
    And I enter "Dummy Account 02" into textbox number 1

    When I toggle button number 1
    When I click back
    And I click back
    And I select Select All
    And I select Select none
    Then there should be 3 cards unselected
    And I should see Liability Two 1111 1111 13

    When I select Select All
    When I swipe up 1 time
    Then I should see Test1

    When I select Test1
    Then I should see The Salisbury Ymca of Hong Kong

    When I touch on screen 125 from the left and 255 from the top
    # search button
    Then I should see Search for your merchant

    When I enter "Tes" into textbox number 1
    Then I should see Test
    And I select Test
    And I should see Other









