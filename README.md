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
11. The default test should run successfully, showing how many scenarios and steps have passed


Note: Please ensure that the iphone simulator you built in xcode is the same as the one you used for calabash. You can specify what simulator calabash uses by first looking for the UDID of the simulator you want by `xcrun simctl list devices`, then putting `DEVICE_TARGET=<UUID>` in front of any commands. For example: `DEVICE_TARGET=338A0C9D-4075-4FC7-BF5E-F61B1097E684 bundle exec cucumber`
 
## How to use the tests

#### Prerequisites: 
1. calabash environment and default test can run on gini app in simulator

#### Setup:
1. Download or clone this repository
2. rename this repository as features
3. replace the features folder inside gini/ios with this direcotory

Do not use `bundle exec cucumber` directly, as it will execute all feature files in alphabetical order, which takes a very long time and is not in the correct order. To run the full test suite, make sure the app is initially on first page of onboarding slides and in English, then use `bundle exec cucumber features/onboarding.features features/forgot_password.feature ...`, filling in all the feature files in order according to the table below, as each feature file's initial settings are set in the previous feature file.

You can execute separate feature files using `bundle exec cucumber -t <tag>`, as each feature file has an unique tag, as listed in the table below.

Note that as the gini app evolves, the tests should be modified to match, otherwise if one test in a feature file fails, all following steps can fail as well, so make sure the tests denote expected behaviour before employing them.

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
| transaction_search.feature | @tsearch | in main app interface, app in English | only partially working due to react-native view architecture |
| transaction_feed.feature | @tfeed | in main app interface, app in English | has the specified bank cards in the feature file, only partially working due to react-native view architecture |
| reports.feature | @reports | in main app interface, app in English, reports page in July |  |
| accounts.feature | @accounts | in main app interface, app in English, bank cards all selected | |




## How to write more tests?

The test suite is currently incomplete, as most tests are in English instead of in both languages, and some tests are difficult to run automatically. So feel free to add more step definitions and feature files to make the test suite better! Please refer to the google sheet for the full manual test suite. The tests not covered are highlighted in blue and purple.

The priniple behind the automated tests is simple. the feature files inside gini/features have the steps written with Gherkin, the language used by cucumber for writing automated tests. The steps in the feature files are then matched with the regex in step definitions in gini/features/steps/gini_steps.rb, which executes the code in the .rb file if matched. 

### Feature file structure

Please feel free to read up more on Gherkin, but here is a brief introduction of feature files and Gherkin, so you should be able to start writing your own tests after reading this and referring to the other feature files.

If you open a feature file, e.g. forgot_password.feature, you can see the basic structure of a feature file consists of the following: Tag, Feature, Background, Scenarios and Scenario Outlines. Under Background, Scenarios and Scenario Outlines, you can see steps written in highly readable syntax. Under Scenario Outlines, there is also an extra section named Examples. Let's go through them one by one.

#### Tag
Tag is optional, but it is easier to execute a particular feature file using tags instead of specifying the file name. For example, with a tag, I can use `bundle exec cucumber -t @tfeed` instead of `bundle exec cucumber features/transation_feed` to execute the transaction feed page tests.
#### Feature
Feature simply states the feature that you are testing in this feature file.
#### Scenario
Each scenario describes one test you want to run on this feature using steps. After each scenario, the app inside the simulator restarts and execute the next scenario.
#### Scenario Outline
Similar to scenario, used when you want to execute the same scenario with different parameters. use `<>` to enclose the parameter to be varied, and list the different test cases in the Examples section. After each test case is run, the app restarts to run the next test case. Take the following scenario outline as an example:

```
Scenario Outline: press diffeent buttons
  Given I select <button>

Examples:
  |button|
  |Login|
  |Sign up|
```
Then in the scenario outline, Login button will be pressed first, and after the whole scenario finishes, the app restarts and rerun the scenario again but pressing the Sign up button instead.
#### Background
Similar to Scenario, but the steps stated in Background are run before each scenario and scenario outline.

### How to write steps
So we know steps have to be written in Scenarios, Scenario Outlines and Background. How do we write it?

There are default steps provided by calabash and custom step definitions defined in `features/steps/gini_steps.rb` Please find a summary of all the steps used in the feature files in `gini_step_definitions.csv`.

With the steps, you add Given/When/Then/And before each step to form coherent test cases. Given is for stating prerequisites, When is for the main action of the test, Then is the result of that action, and And is for any conjunction between the above.

It should be noted that these four keywords do not have any differences in terms of functionality, it is just for making the test more readable.


### Step definitions
Although a lot of step definitions have already been defined for this app, you may want to modify the step definitions or create new ones yourself.

The step definitions are written in ruby, and is in gini/ios/features/steps/gini_steps.rb.
One example of step definition is as below:
```
Given(/^the app has launched$/) do
  wait_for do
    !query("*").empty?
  end
end
```

So it is `Given/When/Then/And` + (`regex for step`) + do + `code executed` + end
The feature file tries to match the step with the regex in the step definition file, then executes the code within.

You can also take the variables inside the step as parameters to the function executed.

```
When(/^I swipe (left|right|up|down) (\d+) times?(?: (strong|normal|light))?$/) do |dir,times,strength|
    $i = 0
    strength ||= "strong"
    $num = times.to_i
    while $i < $num do
        if strength == ""
            swipe(dir, force: :strong)
        else
            swipe(dir, force: :"#{strength}")
        end
        wait_for_none_animating
        $i +=1
    end
end
```
An example of this step would be `When I swipe up 2 times`. The step definition will then take `up` as `dir`, `2` as `times` and `strength` is defaulted to be `strong`, as denoted in the code. 

Within the step definition, any ruby code is legal, and calabash has a ruby API, you can read more about it [here](https://github.com/calabash/calabash-ios/wiki/Calabash-iOS-Ruby-API). Besides custom step definitions, calabash also provides some default step definitions, some of them are shown [here](http://docs.testmunk.com/en/latest/steps.html). 

## How to setup detox

#### Prerequisites: 
1. Have gini app installed and running in simulator
2. Homebrew
3. Node 8.3.0 or above
4. applesimutils

#### Steps:
1. install detox command line by `npm install -g detox-cli`
2. In terminal, go to root directory of the project (i.e. gini/)
3. Type the following command: `npm install detox --save-dev`
4. Install mocha `npm install mocha --save-dev`
5. Add the following to your `package.json`
```
"detox": {
    "configurations": {
      "ios.sim.debug": {
        "binaryPath": "ios/build/Build/Products/Debug-iphonesimulator/gini.app",
        "build":
          "xcodebuild -project ios/gini.xcodeproj -scheme gini -configuration Debug -sdk iphonesimulator -derivedDataPath ios/build",
        "type": "ios.simulator",
        "name": "iPhone 8 Plus"
      }
    }
 }
```
6. Execute `detox init -r mocha`, which creates a folder named `e2e` in the root directory
7. In xcode, run the gini app (scheme gini, not gini-cal as in calabash tests). Alternatively, run `detox build` in terminal
8. Run `detox test` in terminal to run the default test, which should fail

During my installation, the gini app cannot be built or opened successfully multiple times due to a `Unable to resolve module` error. If you encounter the same problem, try the following.
```
watchman watch-del-all
rm -rf ./node_modules
npm cache clean
yarn cache clean
rm -rf $TMPDIR/react-*
yarn install
npm cache clean
yarn cache clean
yarn add uuid
```
Also, sometimes the app fail to open even if it has been opened successfully before. Cleaning the project usually does the trick.
### Why detox

Calabash works fine for ios native app, but for react native apps with complicated views (i.e. transaction cards, collapsable reports, etc.), some of the calabash queries are inaccurate, making it impossible to write tests for those features in calabash. Detox is designed speicifically for react native apps, and can handle the views correctly.

There are some disadvantages to detox too, such as not reusable steps, need to access elements in code and unexpected behaviour in app (header color change).

### How to modify the steps

For detox, I only setup the environment, and did not implement the test suite. To write the tests, open `firstTest.spec.js` in the `e2e` folder in the root directory, then write corresponding tests.

As seen in the js file, the basic principle for the tests is to identify the element using labels and ids, then interact with it. As some labels can be duplicate, it is optimal to add ids to the element, which requires adding a prop named `testID` to the element and call it by id.

For example, to tap the search button in the transaction feed page, testID named `left` is first assigned to the button as shown here: `<Image resizeMode="center" style={styles.leftIcon} source={leftImage} testID='left'/>`

Then, in `firstTest.spec.js`, I type `await element(by.id('left')).tap()` to tap the button.

Therefore, writing detox tests require you to have an understanding of the app's architecture and where to find each element to be more effective.

