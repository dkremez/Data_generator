require 'capybara/dsl'
require 'ffaker'
require 'ryba'
require 'user_data'

module Tutby
  class Registrator
    include Capybara::DSL

    Capybara.javascript_driver = :webkit
    Capybara.app_host = 'http://profile.tut.by/'

    def initialize(username, pass, first_name, second_name)
      @username = username
      @password = pass
      @first_name = first_name
      @second_name = second_name
      current_driver = :selenium
      app_host = 'http://profile.tut.by/'
    end

    def agree_with_rules
      visit('/')
      click_on('Я согласен с правилами')
    end

    def formFilling
      fill_in('Username', :with => @username)
      check_unique
      fill_in('Password1', :with => @password)
      fill_in('Password2', :with => @password)
      fill_in('Answer', :with => '123')
      fill_in('FirstName', :with => @first_name)
      fill_in('SecondName', :with => @second_name)
      fill_in('_3_1', :with => rand(30).to_s)
      fill_in('_3_3', :with => '1985')
      select('Мужчина', :from => '_4')
      capcha = put_capcha
      fill_in('ap_word' , :with => capcha )
      click_on('reg_btn')
      page.should have_content 'Идентификатор пользователя свободен'
    end

    def put_capch
      puts 'enter the captcha'
      capcha = gets.chomp
    end

    def chek_unique
      unless page.should have_content 'Идентификатор пользователя свободен' 
        @username += rand(10).to_s
        fill_in('Username', :with => username)
        click_on('Проверить')
      end
    end

    def

  end
end

user_data = UserData::DataGenetaror.new

registrator = Tutby::Registrator.new()
