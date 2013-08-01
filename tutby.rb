 # coding: utf-8
require 'RMagick'
require 'capybara' 
require 'capybara/dsl'
require 'capybara-webkit'
require 'ffaker'
require 'ryba'
require 'net/http'
require 'net/http/post/multipart'



Capybara.current_driver = :webkit
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
      Capybara.page.save_screenshot('screenshot.png')
      unlock_capcha
      random_password(size = 8)
      Capybara.fill_in('Password1', :with => @password)
      Capybara.fill_in('Password2', :with => @password)
      Capybara.fill_in('Answer', :with => '123')
      Capybara.fill_in('FirstName', :with => @first_name)
      Capybara.fill_in('SecondName', :with => @second_name)
      Capybara.fill_in('_3_1', :with => '12')
      Capybara.fill_in('_3_3', :with => '1992')
      
      Capybara.select('Мужчина', :from => '_4')
      @capcha = put_capcha
      Capybara.fill_in('ap_word' , :with => @capcha )
      Capybara.click_on('reg_btn')
      Capybara.visit('http://profile.tut.by/change.html')
      
    end
    def generate_nick
      @login = Faker::Name.name.split(' ').join
    end

    def save_only_capca
      screen = Magick::Image.read('screenshot.png').first
      capcha = screen.crop!(480, 1200, 280, 80)
      capcha.write 'capcha.jpg'
    end

    def unlock_capcha
      save_only_capca
    end

    def put_capcha
      key = 'dbdfd415fbf7f460448e74ab948c1b1b'

      capcha = 'capcha.jpg'
      recognition_time = 10

      #recognize capcha
      id = send_captcha( key, capcha )
      sleep( recognition_time )
      code = nil
      while code == nil do
        code = get_captcha_text( key, id )
        sleep 1
      end#while
      puts code
      code.to_s
    end  

    def send_captcha( key, captcha_file )
      uri = URI.parse( 'http://antigate.com/in.php' )
      file = File.new( captcha_file, 'rb' )
      req = Net::HTTP::Post::Multipart.new( uri.path,
                                            :method => 'post',
                                            :key => key,
                                            :file => UploadIO.new( file, 'image/jpeg', 'image.jpg' ),
                                            :is_russian => 1 )
      http = Net::HTTP.new( uri.host, uri.port )
      begin
        resp = http.request( req )
      rescue => err
        puts err
        return nil
      end#begin
      
      id = resp.body
      return id[ 3..id.size ]
    end#def

    def get_captcha_text( key, id )
      data = { :key => key,
               :action => 'get',
               :id => id,
               :min_len => 5,
               :max_len => 5 }
      uri = URI.parse('http://antigate.com/res.php' )
      req = Net::HTTP::Post.new( uri.path )
      http = Net::HTTP.new( uri.host, uri.port )
      req.set_form_data( data )

      begin
        resp = http.request(req)
      rescue => err
        puts err
        return nil
      end
      
      text = resp.body
      if text != "CAPCHA_NOT_READY"
        return text[ 3..text.size ]
      end#if
      return nil
    end#def

    def report_bad( key, id )
      data = { :key => key,
               :action => 'reportbad',
               :id => id }
      uri = URI.parse('http://antigate.com/res.php' )
      req = Net::HTTP::Post.new( uri.path )
      http = Net::HTTP.new( uri.host, uri.port )
      req.set_form_data( data )

      begin
        resp = http.request(req)
      rescue => err
        puts err
      end
    end#def

    
    
  end
end
t = MyModule::Registrator.new
logins = []

puts 'Put number of users'
numberOfUsers = gets.chomp


numberOfUsers.to_i.times do
  t.generate_nick
  t.name_data
  t.rulesAgree
  t.formFilling  
  logins = logins + [t.login + ' ' + t.password]
end
puts logins