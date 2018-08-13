@onboarding
Feature: Onboarding slides


# start at first onboarding slide in English
# go into onboarding slides

Background:
  Given the app has launched
  And I wait for 1 seconds
#  And I select Skip/跳過


Scenario: check swiping left and changing language on last onboarding slide
  When I swipe left 5 times
  And I select 繁體中文
  Then I should see English
  When I select English
  Then I should see 繁體中文
  And I should see Login


Scenario: check swiping right and changing language in middle pages
  When I swipe right 3 times
  And I select 繁體中文
  Then I should not see 輕觸或滑動開始

Scenario: check first page swipe bug
  When I swipe right
  Then I should not see 輕觸或滑動開始

Scenario: check tapping page and skip button
  When I tap the screen 2 times
  And I select 跳過
  Then I should see 登入

Scenario: check sign up button
  When I select 註冊
  Then I should see 出生日期
  #  click back button
  And I click back
  Then I should see 登入

Scenario: check login button and prepare for next tests
  When I select 登入
  Then I should see 忘記密碼
  #  click back button
  When I touch on screen 30 from the left and 30 from the top
  Then I should see 登入
  And I swipe left 5 times

