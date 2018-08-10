# gini-calabash-tests

## How to setup calabash environment
(official calabash tutorial: https://github.com/calabash/calabash-ios/wiki/Tutorial%3A-How-to-add-Calabash-to-Xcode)

#### Prerequisites: 
1. Have gini app installed and running in simulator
2. ruby version >2.0

#### Steps:
1. In terminal, go to directory containing the .xcodeproj (i.e. gini/ios)
2. execute `gem install calabash-cucumber`
3. Open the xcode project in xcode, right click on the Frameworks directory in the file explorer, and click "Add files to ..."
4. Add calabash.framework
5. In terminal, execute `calabash-ios setup` and answer the questions accordingly, sticking to the default options
6. execute `calabash-ios gen` to create the features folder
7. In xcode, build the gini-cal project to make sure it works
8. In the project directory, edit the Gemfile and make sure the gem file at least contain the following lines:
```
source "https://rubygems.org"
  
gem "calabash-cucumber", ">= 0.21.5", "< 2.0"
gem "cucumber", "~> 2.4"
```
9. In terminal, execute `bundle install` to install the gems using bundler
10. execute `bundle exec cucumber` to run the default test
11. The default test should run successfully


## How to use the tests

#### Prerequisites: 
1. calabash environment and default test can run on gini app in simulator

#### Setup:
1. Download or clone this repository
2. rename this repository as features
3. replace the features folder inside gini/ios with this direcotory

Do not use `bundle exec cucumber` directly, as it will execute all feature files in alphabetical order, which takes a very long time and is not in the correct order. To run the full test suite, use `bundle exec cucumber ...`, making sure the app is initially on first page of onboarding slides and in English.

You can execute separate feature files using `bundle exec cucumber -t <tag>`, as each feature file has an unique tag, as listed in the table below.

#### Feature files

| Feature File | Tag | Initial Conditions | Remarks |
| --- | --- | --- | --- |
| onboarding.feature | @onboarding | at first page of onboarding slides, app set in English ||
| forgot_password.feature | @forgot | at last page of onboarding slides, app set in English ||
| create_acc.feature | @createAcc | at last page of onboarding slides, app set in English | change the email at the last example each time this feature file is run, as a new email has to be used for each new account |
| login_page.feature | @login | at last page of onboarding slides, app set in English |  |
| create_pw.feature | @createpw | logged in, but pw not created yet |  |
| bank_login.feature | @banklogin | logged in, already entered pw as 333333 |  |
| settings.feature | @settings | linked banks, in main app interface |  |
| settings_general.feature | @settingsg | in main app interface, app in English and transaction amount not hidden |  |
| transaction_search.feature | @tsearch | in main app interface, app in English |  |
| transaction_feed.feature | @tfeed | in main app interface, app in English | has the specified bank cards in the feature file |
| reports.feature | @reports | in main app interface, app in English, reports page in July |  |




## How to write more tests?

The test suite is currently incomplete, as most tests are in English, and some tests are difficult to run automatically. So feel free to add more step definitions and feature files to make the test suite better!

The priniple behind the automated tests is simple. the feature files inside gini/features have the steps written with Gherkin, the language used by cucumber for writing automated tests. The steps in the feature files are then matched with the regex in step definitions in gini/features/steps/gini_steps.rb, which executes the code in the .rb file if matched. 

### Brief Introduction to Gherkin

Please feel free to read up more on Gherkin, but here is a bried introduction of Gherkin, so you should be able to start writing your own tests after reading this and referring to the other feature files.

If you open the 


#### Step definitions




