@settingsg
Feature: settings - general page
# set app to English first and linked banks already, transaction amount not hidden

Background:
    Given the app has launched
    And I wait for Continue for 10 seconds
    And I wait for 1 second
#    And I select Skip/跳過
    And I enter 333333 as passcode
    When I select Continue
    Then I should see Transaction Feed/最新動態

    When I swipe left 3 times
    Then I should see Log Out

    When I select General
    Then I should see Change email

Scenario: toggle buttons (amount hidden)
    When I toggle button number 1
    And I toggle button number 1

    When I toggle button number 2
    And I click back
    And I select Feed
    And I wait for Nike for 10 seconds
    Then I should not see -$999

    When I select Settings
    And I select General

    When I toggle button number 2
    And I click back
    And I select Feed
    And I wait for Nike for 10 seconds
    Then I should see -$400


Scenario: change language
    When I select Change Language (語言)
    Then I should see Language

    When I select English
    And I click back
    Then I should see General

    When I select Change Language (語言)
    Then I should see Language

    When I select 繁體中文
    And I click back
    Then I should see 一般

    When I select 語言設定 (Language)
    Then I should see 語言

    When I select English
    And I click back
    Then I should see General


Scenario Outline: change password - current password (invalid)
    When I select Change password
    Then I should see Save

    When I enter "<password>" into textbox number 2
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
    When I select Change password
    Then I should see Save

    When I enter "<password>" into textbox number 2
    And I enter "" into textbox number 1
    Then I should not see Your password need to have:

Examples:
    |password|
    |Aa000000|
    |Demodem0|


Scenario Outline: check confirm new password validity (different from new password)
    When I select Change password
    Then I should see Save

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
    When I select Change password
    Then I should see Save

    When I enter "<password>" into textbox number 2
    And I enter "<new_password>" into textbox number 3
    And I enter "" into textbox number 1
    Then I should not see Please enter correct password

Examples:
    |password|new_password|
    |Aa000000|Aa000000|
    |abc|abc|

Scenario Outline: check save button (invalid credentials)
    When I select Change password
    Then I should see Save

    When I enter "<old_password>" into textbox number 1
    And I enter "<password>" into textbox number 2
    And I enter "<new_password>" into textbox number 3
    And I select Save
    Then I wait for Error for 5 seconds
    And I select OK
    And I should see Change password

Examples:
    |old_password|password|new_password|
    |demodemo|Aa000000|Aa000001|
    |demodemo|||
    ||||
    |abc|Aa000000|Aa000000|
    ||Aa000000|Aa000000|


