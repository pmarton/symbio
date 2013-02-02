Given /^the current time is "([^\"]*)"$/ do |time|
  Time.stub(:current).and_return(Time.parse(time))
end

Then /^I should see a link called "([^\"]*)"$/ do |text|
  has_selector?("a", :text => text)
end

Then /^I should not see a link called "([^\"]*)"$/ do |text|
  has_no_selector?("a", :text => text)
end

When /^I log in as a user$/ do
  fill_in("E-Mail", :with => "user@hoefler.st")
  fill_in("Passwort", :with => "test123")
  click_button("Anmelden")
end

When /^I log in as an admin$/ do
  fill_in("E-Mail", :with => "user@hoefler.st")
  fill_in("Passwort", :with => "test123")
  click_button("Anmelden")
end