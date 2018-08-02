@createAcc
Feature: Create Account page

# set app to English first and at last onboarding page
# change email in last scenario outline (check next button) every time you run this feature test

Background:
    Given the app has launched
    And I select Skip/跳過
    And I select Sign up/註冊

Scenario: changing language without text
    Given I should see Confirm New Password
    When I select 繁體中文
    Then I should see English


Scenario: changing text in textbox and changing language with text
    Given I enter "abc" into textbox number 1
    And I enter "def" into textbox number 2
    When I select 繁體中文/English
    Then textbox number 1 should be empty
    And textbox number 2 should be empty


Scenario: check back button and login button
    Given I click back
    And I should see Join gini waitlist
    When I select Sign up
    Then I should see Confirm New Password

    Given I select Login.
    When I should see Sign up
    And I touch on screen 245 from the left and 400 from the top
    # sign up button
    Then I should see New Password


Scenario: check T&C and Private policy button
    When I touch on screen 188 from the left and 583 from the top
# T&C
    Then I should see 1. App Provider

    Given I click back
    And I should see New Password
    When I touch on screen 188 from the left and 610 from the top
# Private policy
    Then I should see 1. Data user


Scenario Outline: check email validity (invalid)
    When I enter "<username>" into textbox number 1
    And I enter "" into textbox number 2
    Then I should see Please enter valid email

Examples:
    |username|
    |a|
    |a@|
    |a@a|
    |a@a.c|
    |@a.co|
    |a.c|
    |a.co|
    ||


Scenario Outline: check email validity (valid)
    When I enter "<username>" into textbox number 1
    And I enter "" into textbox number 2
    Then I should not see Please enter valid email

Examples:
    |username|
    |a@a.com|
    |demo@gini.co|


Scenario Outline: check new password validity (invalid)
    When I enter "<password>" into textbox number 2
    And I enter "" into textbox number 1
    Then I should see Your password need to have:

Examples:
    |password|
    ||
    |A|
    |a|
    |0|
    |@@@@@@@@|
    |Aa|
    |A0|
    |AAAAAAAA|
    |a0|
    |aaaaaaaa|
    |00000000|
    |Aa0|
    |Aaaaaaaa|
    |A0000000|
    |a0000000|


Scenario Outline: check new password validity (valid)
    When I enter "<password>" into textbox number 2
    And I enter "" into textbox number 1
    Then I should not see Your password need to have:

Examples:
    |password|
    |Aa000000|
    |Demodem0|


Scenario Outline: check confirm new password validity (different from new password)
    When I enter "<password>" into textbox number 2
    And I enter "<new_password>" into textbox number 3
    And I enter "" into textbox number 1
    Then I should see Please enter correct password

Examples:
    |password|new_password|
    |Aa000000|Aa000001|
    |Aa000000||
    |abc|Aa000000|
    |abc|aja|
    |abc||


Scenario Outline: check confirm new password validity (same as new password)
    When I enter "<password>" into textbox number 2
    And I enter "<new_password>" into textbox number 3
    And I enter "" into textbox number 1
    Then I should not see Please enter correct password

Examples:
    |password|new_password|
    |Aa000000|Aa000000|
    |abc|abc|


Scenario Outline: check date of birth (invalid)
    Given I touch on screen 100 from the left and 400 from the top
# date of birth
    When I change the date picker date to "<date>"
    And I select Confirm
    Then I should see Invalid date of birth. You must be at least 18 years old to register

Examples:
    |date|
    |August 18 2000|
    |August 18 2018|
    |August 18 2036|


Scenario Outline: check date of birth (valid)
    Given I touch on screen 100 from the left and 400 from the top
# date of birth
    When I change the date picker date to "<date>"
    And I select Confirm
    Then I should not see Invalid date of birth. You must be at least 18 years old to register

Examples:
    |date|
    |July 30 2000|
    |July 29 2000|
    |July 30 1900|


Scenario: check Date of birth cancel button
    Given I touch on screen 100 from the left and 400 from the top
# date of birth
    When I change the date picker date to "August 18 2000"
    And I select Cancel
    Then I should see foo/(DD/MM/YY)


Scenario Outline: check Next button (unclickable)
    When I touch on screen 100 from the left and 400 from the top
# date of birth
    And I change the date picker date to "<date>"
    And I select Confirm
    And I enter "<email>" into textbox number 1
    And I enter "<pw>" into textbox number 2
    And I enter "<newpw>" into textbox number 3
    And I select Email
    Then the submit button labeled Next should be unclickable

Examples:
    |email|pw|newpw|date|
    ||||August 18 2000|
    |abc|abc|abc|July 18 2000|
    ||Aa000000|Aa000000|July 18 2000|
    |abc@abc.com|Aa000000|Aa000001|July 18 2000|
    |abc@abc.com|Aa000000||July 18 2000|
    |abc@abc.com||Aa000001|July 18 2000|
    |abc@abc.com|Aa000000|Aa000000|August 18 2000|

Scenario Outline: check Next button (clickable)
    When I touch on screen 100 from the left and 400 from the top
# date of birth
    And I change the date picker date to "<date>"
    And I select Confirm
    And I enter "<email>" into textbox number 1
    And I enter "<pw>" into textbox number 2
    And I enter "<newpw>" into textbox number 3
    And I select Email
    Then the submit button labeled Next should be clickable
    And I touch on screen 100 from the left and 500 from the top
    #Next button
    And I wait for 1 second
    Then I should see Enter Promo Code
    And I select Enter Promo Code
    Then I should see Get me in
    And I select Logout
    And I swipe left 5 times
# prepare for next test

Examples:
|email|pw|newpw|date|
|automated4@testing.com|Aa000000|Aa000000|July 18 2000|



