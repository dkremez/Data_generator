 # coding: utf-8
require 'rubygems'
require 'capybara' 
require 'capybara/dsl'
require 'ffaker'
require 'ryba' 


Capybara.current_driver = :selenium
Capybara.app_host = 'http://profile.tut.by/' 
module MyModule

  class Registrator

    attr_accessor :login, :password

    def name_data
      name_data = Faker::Name.name.split(' ')
      @first_name = name_data[0]
      @second_name = name_data[1]
    end

    def random_password(size = 8)
      chars = (('a'..'z').to_a + ('0'..'9').to_a) - %w(i o 0 1 l 0)
      @password = (1..size).collect{|a| chars[rand(chars.size)] }.join
    end

    def rulesAgree
      Capybara.visit('/')
      Capybara.click_on('Я согласен с правилами')
    end
    def formFilling
    
      Capybara.fill_in('Username', :with => @login)
      Capybara.click_on('Проверить')
      random_password(size = 8)
      Capybara.fill_in('Password1', :with => @password)
      Capybara.fill_in('Password2', :with => @password)
      Capybara.fill_in('Answer', :with => '123')
      Capybara.fill_in('FirstName', :with => @first_name)
      Capybara.fill_in('SecondName', :with => @second_name)
      Capybara.fill_in('_3_1', :with => '12')
      Capybara.fill_in('_3_3', :with => '1992')
      
      Capybara.select('Мужчина', :from => '_4')
      put_capcha
      Capybara.fill_in('ap_word' , :with => @capcha )
      Capybara.click_on('reg_btn')
      Capybara.visit('http://profile.tut.by/change.html')
      
    end
    def generate_nick
      @login = Faker::Name.name.split(' ').join
    end

    def put_capcha
      puts 'enter the captcha'
      @capcha = gets.chomp
    end  
    
  end
end
t = MyModule::Registrator.new
logins = []

puts 'Put number of users'
numberOfUsers = gets

i=0
while i < numberOfUsers.to_i
  t.generate_nick
  t.name_data
  t.rulesAgree
  t.formFilling  
  logins = logins + [t.login + ' ' + t.password]
  i+=1
end
puts logins