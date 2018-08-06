Given(/^the app has launched$/) do
  wait_for do
    !query("*").empty?
  end
end

#And(/^I have done a specific thing$/) do
#  # Example: Given I am logged in
#  #  wait_for do
#  #    !query("* marked:'username'").empty?
#  #  end
#  #
#  #  touch("* marked:'username'")
#  #  wait_for_keyboard
#  #  keyboard_enter_text("cleveruser27")
#  #
#  #  touch("* marked:'password'")
#  #  wait_for_keyboard
#  #  keyboard_enter_text("pa$$w0rd")
#  #
#  #  wait_for_element_exists("* marked:'Login'")
#  #  touch("* marked:'Login'")
#
#
#  #touch("button")[0]
#  # Remember: any Ruby is allowed in your step definitions
#  did_something = true
#
#  unless did_something
#    fail 'Expected to have done something'
#  end
#end
#
#
#And(/^I have selected all correct buttons$/) do
#    wait_for(:timeout => 2){ element_exists("* marked:'Skip'")}
#    touch("* marked:'Skip'")[0]
#    sleep(1)
#end
#
#When(/^I do something$/) do
#  # Example: When I create a new entry
#  #  tap("* marked:'new_entry'")
#  #  wait_for_keyboard
#  #  keyboard_enter_text("* marked:'entry_title'", 'My Entry')
#  #
#  #  tap("* marked:'submit'")
#
#
##  wait_for_element_exists("UILabel marked:'Photo Gallery'")
##  if element_exists("* marked:'Photo Gallery'") == false
##    fail "ahh"
##  else
##     puts "exists"
##  end
##  sleep(0.4)
##  touch("* marked:'Photo Gallery'")
#end
#
#Then(/^something should happen$/) do
#  # Example: Then I should see the entry on my home page
#  #  wait_for_element_exists("* text:'My Entry'")
#  #touch("* marked:'Photo Gallery'")
##  wait_for(:timeout => 2){ element_exists("UINavigationBar marked:'Photos'")}
##  val = element_exists("UINavigationBar marked:'Photos'")
##  if val == true
##      puts "test passed, goes into Photo Gallery"
##  else
##      fail "photo gallery not loaded"
##  end
#end


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
    
When(/^I off-center swipe (left|right|up|down) (\d+) times?(?: (strong|normal|light))?$/) do |dir,times,strength|
    $i = 0
    strength ||= "strong"
    $num = times.to_i
    while $i < $num do
        if strength == ""
            swipe(dir, :offset => {:x => 0, :y => 200}, force: :strong)
            else
            swipe(dir, :offset => {:x => 0, :y => 200}, force: :"#{strength}")
        end
        wait_for_none_animating
        $i +=1
    end
end

Then (/^I select ([^\/]*)\/?(?:(.*))?$/) do |name1, name2|
    #    wait_for_none_animating
    val1 = element_exists("view marked:'#{name1}'")
    val2 = element_exists("view marked:'#{name2}'")
    if val1 == true
        touch("view marked:'#{name1}'")
        puts "selected #{name1}"
    elsif (val2 == true) && name2 != ""
        touch("view marked:'#{name2}'")
        puts "selected #{name2}"
    else
        fail "cannot find #{name1} or #{name2}"
    end
    sleep(STEP_PAUSE)
end

#Then (/^I select (.*)?$/) do |name1|
#    sleep(1)
#    val1 = element_exists("view marked:'#{name1}'")
#    if val1 == true
#        touch("view marked:'#{name1}'")
#    else
#        fail "cannot find #{name1}"
#    end
#    sleep (1)
#end

Then (/^I tap the screen (\d+) times?$/) do |times|
    $i = 0
    $num = times.to_i
    while $i < $num do
        touch(nil, {:offset => {:x => 0, :y => 0}})
        wait_for_none_animating
        $i +=1
    end
end

Then (/^I should see ([^\/]*)\/?(?:(.*))?$/) do |name1, name2|
    val1 = element_exists("view marked:'#{name1}'")
    val2 = element_exists("view marked:'#{name2}'")
    if val1 == true
       puts "found #{name1}"
    elsif val2 == true
        puts "found #{name2}"
    end

    
    if val1 == false && (val2 == false || name2 == "")
        fail "cannot find #{name1} or #{name2}"
    end
    sleep(STEP_PAUSE)
end
                           
#Then (/^I should see (.*)$/) do |name|
#    wait_for(:timeout => 2){ element_exists("view marked:'#{name}'")}
#    val = element_exists("view marked:'#{name}'")
#    if val == false
#        fail "cannot find #{name}"
#    end
#end

#Then (/^I should not see (.*)$/) do |name|
#    sleep(0.5)
#    val = element_exists("view marked:'#{name}'")
#    if val == true
#       fail "can find #{name}"
#    end
#end

Then (/^I should not see ([^\/]*)\/?(?:(.*))?$/) do |name1, name2|
    wait_for_none_animating
    val1 = element_exists("view marked:'#{name1}'")
    val2 = element_exists("view marked:'#{name2}'")
    if val1 == true || (val2 == true && name2 != "")
        fail "can find #{name1} or #{name2}"
    end
    sleep(STEP_PAUSE)
end
                  
Then (/^I click back$/) do
    touch(nil, {:offset => {:x => 30, :y => 30}})
    sleep(STEP_PAUSE)
end

When (/^I enter "([^"]*)" into textbox number (\d+)$/) do |text, index|
touch("UITextField index:#{index.to_i-1}")
    wait_for_keyboard()
    while query("UITextField", :text)[index.to_i-1] != ""
        keyboard_enter_char 'Delete'
    end
    keyboard_enter_text text
    actual_text = query("UITextField", :text)[index.to_i-1]
    length = text.length
    if actual_text != text
        puts "lol outputs #{actual_text}"
        $i = 0
        $num = length.to_i
        while query("UITextField", :text)[index.to_i-1] != ""
            keyboard_enter_char 'Delete'
        end
        while $i < $num do
            keyboard_enter_char text[$i]
            $i += 1
        end
    end
#    keyboard_enter_char 'Return'
    sleep(STEP_PAUSE)
end

Then (/^textbox number (\d+) should be empty$/) do |index|
    if query("UITextField", :text)[index.to_i-1] != ""
        fail "textfield not empty"
    end
end

Then (/^textbox number (\d+) should not be empty$/) do |index|
    if query("UITextField", :text)[index.to_i-1] == ""
        fail "textfield not empty"
    end
end

And (/^ I wait for (\d+) seconds?$/) do |seconds|
    sleep(seconds.to_i)
end
    
Then (/^the submit button labeled (\w+) should be unclickable$/) do |label|
    if query("view marked:'#{label}'", "alpha").include? 0.5 == false
        fail "no unclickable item labeled #{label}"
    end
end

Then (/^the submit button labeled (\w+) should be clickable$/) do |label|
    if query("view marked:'#{label}'", "alpha").include? 0.5 == true
        fail "no unclickable item labeled #{label}"
    end
end
    
Then (/^I enter (\d+) as passcode$/) do |pw|
    $i = 0
    touch("UITextField index:0")
    while query("UITextField", :text)[0] != ""
        keyboard_enter_char 'Delete'
    end
    while $i < 6
        keyboard_enter_char pw[$i]
        $i += 1
    end
end

And (/^I wait for (.*) for (\d+) seconds?$/) do |element, time|
    wait_for(:timeout => time.to_i){ element_exists("view marked:'#{element}'")}
end
    
And (/^I toggle button number (\d+)$/) do |index|
    touch("switch index:#{index.to_i-1}")
    val = query("switch")[index.to_i-1]["value"]
    if val == "1"
        puts "toggled button number #{index.to_i} from off to on"
    elsif val == "0"
        puts "toggled button number #{index.to_i} from on to off"
    else
        fail "something went wrong"
    end
end
    
