@banklogin
Feature: bank login page

Background:
    Given the app has launched
    And I wait for Continue for 10 seconds
#    And I select Skip/跳過
    And I wait for 4 seconds
    And I enter 333333 as passcode
    When I select Continue
    Then I should see Bank Accounts
# set app to English first



Scenario Outline: go into hang seng/hsbc login page, test back button and login
When I swipe up 1 time
And I wait for 2 seconds
When I select <bank>
Then I should see <banklogin>

# check info button
When I touch on screen 120 from the left and 250 from the top
# Username info button
Then I should see This will be the same as the one you use for your <bank> online banking.
When I select OK
Then I should not see his will be the same as the one you use for your <bank> online banking.

# check username/pw validity (empty)
When I enter "" into textbox number 1
And I enter "" into textbox number 2
And I swipe up <swipe> time light
And I enter "" into textbox number <three>
And I select Your username
Then I should see Please enter valid username
And I should see Please enter valid password
And I should see Please enter valid <option3>
And the submit button labeled Link should be unclickable

# check username/pw validity (not empty)
When I enter "@" into textbox number 1
And I enter "@" into textbox number 2
And I swipe up 1 time light
And I enter "@" into textbox number <three>
And I enter "@" into textbox number 1
Then I should not see Please enter valid username
And I should not see Please enter valid password
And I should not see Please enter <option3>
And the submit button labeled Link should be clickable


# check login
When I select Link
#And I select Link
Then I wait for Link Bank Accounts for 3 seconds
And I wait for Report error for 30 seconds
And I select Close
#And I select Close
And I should see <banklogin>


# check back button
When I click back
Then I should see Bank Accounts

Examples:
|bank|banklogin|three|option3|swipe|
|Hang Seng Bank|Hang Seng Login|3|second password|1|
|HSBC|HSBC Login|3|memorable answer|1|







Scenario: go to BOC, test back button and check wrong login

#Go to BOC
    When I touch on screen 200 from the left and 350 from the top
#BOC icon
    Then I should see Bank of China Login


# check info button
    When I touch on screen 120 from the left and 250 from the top
# Username info button
    Then I should see This will be the same as the one you use for your Bank of China (HK)  online banking.
    When I select OK
    Then I should not see his will be the same as the one you use for your Bank of China (HK)  online banking.

# check username/pw validity (empty)
    When I enter "" into textbox number 1
    And I enter "" into textbox number 2
    And I select Your username
    Then I should see Please enter valid username
    And I should see Please enter valid password
    And the submit button labeled Link should be unclickable

# check username/pw validity (not empty)
    When I enter "@" into textbox number 1
    And I enter "@" into textbox number 2
    And I enter "@" into textbox number 1
    Then I should not see Please enter valid username
    And I should not see Please enter valid password
    And the submit button labeled Link should be clickable


# check login (bugged with no popup)
    When I select Link
    And I select Link
    Then I wait for Link Bank Accounts for 3 seconds
    And I wait for Link for 5 seconds
    And I wait for 1 second

    When I enter "abcd" into textbox number 3
    And I enter "a" into textbox number 2
    Then I select Link
    And I wait for Link Bank Accounts for 3 seconds
    And I wait for Password for 5 seconds

# check back button
    When I click back
    Then I should see Bank Accounts






Scenario Outline: go into each bank login page (except BOC/Hnag Seng/HSBC), test back button and login (AMEX fails)
    When I swipe up <swipe> time
    And I wait for 2 seconds
    When I select <bank>
    Then I should see <banklogin>

# check info button
    When I touch on screen 120 from the left and 250 from the top
# Username info button
    Then I should see This will be the same as the one you use for your <bank> online banking.
    When I select OK
    Then I should not see his will be the same as the one you use for your <bank> online banking.

# check username/pw validity (empty)
    When I enter "" into textbox number 1
    And I enter "" into textbox number 2
    And I swipe up <swipe> time light
    And I enter "" into textbox number <three>
    And I select Your username
    Then I should see Please enter valid username
    And I should see Please enter valid password
    And I should see Please enter valid <option3>
    And the submit button labeled Link should be unclickable

# check username/pw validity (not empty)
    When I enter "@" into textbox number 1
    And I enter "@" into textbox number 2
    And I swipe up 1 time light
    And I enter "@" into textbox number <three>
    And I enter "@" into textbox number 1
    Then I should not see Please enter valid username
    And I should not see Please enter valid password
    And I should not see Please enter <option3>
    And the submit button labeled Link should be clickable


# check login
    When I select Link
    And I select Link
    Then I wait for Link Bank Accounts for 3 seconds
    And I wait for Report error for 30 seconds
    And I select Close
#    And I select Close
#    And I wait for <banklogin> for 3 seconds
# And I should see <banklogin>


# check back button
    When I click back
    Then I should see Bank Accounts

Examples:
    |bank|banklogin|three|option3|swipe|
    |Demobank 2|Demobank 2 Login|1|password|0|
    |American Express (HK)|American Express Login|1|password|0|
    |Bank of East Asia (HK)|Bank of East Asia Login|1|password|0|
    |Citibank|Citibank Login|1|password|0|
    |Standard Chartered (HK)|Standard Chartered Login|1|password|1|





Scenario: Login to demobank

    When I select Demobank 2
    And I enter "user01" into textbox number 1
    And I enter "user01" into textbox number 2
    And I swipe up 1 time light

    And I select Link

    Then I wait for Later for 30 seconds
    And I select Later
    And I wait for Transaction Feed for 10 seconds

