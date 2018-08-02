@login
Feature: Login page

Background:
    Given I select Skip/跳過
    And I select Login/登入


# set app to English first


Scenario: changing language without text
    Given I should see Forgot your password?
    When I select 繁體中文
    Then I should see 忘記密碼

Scenario: changing text in textbox and changing language with text
    Given I enter "abc" into textbox number 1
    And I enter "def" into textbox number 1
    When I select 繁體中文/English
    Then textbox number 1 should be empty

Scenario: check forget password button, sign up button and back button
    When I select Forgot your password?
    Then I should see Enter your email below to reset your password.

    Given I click back
    And I should see Forgot your password?
    When I touch on screen 245 from the left and 400 from the top
# sign up button
    Then I should see New Password

    Given I click back
    And I select Login
    When I click back
    Then I should see Join gini waitlist


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


Scenario Outline: check Login button (unclickable)
    When I enter "<username>" into textbox number 1
    And I enter "<password>" into textbox number 2
    Then the submit button labeled Login should be unclickable

Examples:
    |username|password|
    |a@a.com||
    ||abc|
    |||
    |abc|abc|
    |abc||

Scenario: check Login button (clickable but incorrect credentials)
    When I enter "a@a.co" into textbox number 1
    And I enter "abcd" into textbox number 2
    Then the submit button labeled Login should be clickable

    When I touch on screen 30 from the left and 300 from the top
    And I select OK
    Then I should see Forgot your password?

Scenario: check Login button (clickable but correct credentials)
    When I enter "demo@gini.co" into textbox number 1
    And I enter "demodemo" into textbox number 2
    Then the submit button labeled Login should be clickable

    When I touch on screen 30 from the left and 300 from the top
    And I wait for Create new passcode for 13 seconds
    Then I should see Create new passcode





