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

Then /^output length should be "([^'']*)"$/ do |expected_lenght|
	@name.lenght == expected_lenght.to_i
end

