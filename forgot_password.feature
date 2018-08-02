@forgot
Feature: Forgot password page
# set app to English first and at last onboarding page

Background:
    Given the app has launched
    And I select Skip/跳過
    And I select Login/登入
    And I select Forgot your password?/忘記密碼

Scenario: changing language without text
    Given textbox number 1 should be empty
    When I touch on screen 310 from the left and 40 from the top
# language button
    Then I should see 繁體中文

    When I touch on screen 310 from the left and 40 from the top
    Then I should see English


Scenario: changing text in textbox and changing language with text
    Given I enter "abc" into textbox number 1
    And I enter "def" into textbox number 1
    When I touch on screen 310 from the left and 40 from the top
# language button
    Then textbox number 1 should be empty

Scenario: check back button
    Given I click back
    And I should see 登入/Log in
    When I select Forgot your password?/忘記密碼
    Then I should see Your email/你的電郵地址


Scenario Outline: check email validity and login button (invalid)
    When I enter "<email>" into textbox number 1
    And I select Email/電郵地址
    Then I should see Please enter valid email
    And the submit button labeled Submit should be unclickable

Examples:
    |email|
    |a|
    |a@|
    |a@a|
    |a@a.c|
    |@a.co|
    |a.c|
    |a.co|
    ||

Scenario Outline: check email validity (valid)
    When I enter "<email>" into textbox number 1
    And I select Email/電郵地址
    Then I should not see Please enter valid email

Examples:
    |email|
    |a@a.com|
    |demo@gini.co|

Scenario: check Login button (valid)
    When I enter "demo@gini.co" into textbox number 1
    Then the submit button labeled Submit should be clickable

    When I select Submit
    And I wait for OK for 5 seconds
    And I select OK
    Then I should see Sign up




