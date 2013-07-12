Given /^the input "([^'']*)"$/ do |language|
  @language = language
end

Given /^input "([^'']*)"$/ do |nature_number|
  @number = nature_number
end

Given /^"([^'']*)"$/ do |misstake_percentage|
 @misstake_percentage = misstake_percentage
end

When /^the test_data_generator is run$/ do
  `ruby test_data_generator.rb #{@language} #{@number} #{@misstake_percentage}`
  raise('Command Faild!') unless $?.success?
end

Then /^output name should be "([^'']*)"$/ do |expected_name|
  @name.should == expected_name
end

Then /^adress: "([^'']*)"$/ do |expected_address|
  @address.should == expected_adress
end

Then /^telephone: "([^'']*)"$/ do |expected_phone_number|
  @phone_number.should == expected_phone_number
end