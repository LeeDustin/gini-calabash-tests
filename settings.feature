@settings
Feature: settings page
# set app to English first and at last onboarding page

Background:
    Given the app has launched
    And I wait for Continue for 10 seconds
    And I wait for 1 second
    And I select Skip/跳過
    And I enter 333333 as passcode
    When I select Continue
    Then I should see Transaction Feed/最新動態

Scenario: Navigation Bar (swiping)
    When I swipe right 1 time
    Then I should see Transaction Feed

    When I swipe left 3 times
    Then I should see Log Out

    When I off-center swipe left 1 time
    Then I should see Log Out

    When I off-center swipe right 2 times
    Then I should see Monthly spend


Scenario: Navigation Bar (tapping icons)
    When I select Report
    Then I should see Monthly spend

    When I select Accounts
    Then I should not see Monthly spend

    When I select Settings
    Then I should see Log Out

    When I select Report
    Then I should see Monthly spend


Scenario: check settings buttons (cannot test Invite friends)
    When I swipe left 3 times
    Then I should see Log Out

    When I select General
    Then I should see Change email
    And I click back

    When I select Accounts
    Then I should see Bank Accounts
    And I click back

    When I select Help and feedback
    Then I should see How can we help you?
    And I select Cancel

    When I select Log Out
    Then I should see Log out of gini?
    And I select Close

    When I select Invite friends
    And I wait for 2 seconds










