# coding: utf-8
require 'ffaker'
require 'ryba'

module UserData
  class DataGeneraror

    MAX_PHONE_NUMBER = 9999999

    def initialize(locale, number, error_percent)
      @locale = locale
      @N = number
      @error_percent = error_percent
    end

    def main 
      (@N*@error_percent).to_i.times do  
        if @locale == "US"
            p make_wrong generate_us_data 
          elsif @locale == "RU"
            p make_wrong generate_ru_data 
          elsif @locale == "BY"
            p make_wrong generate_by_data
        end
      end

      (@N-@N*@error_percent).to_i.times do
        if @locale == "US"
            p generate_us_data
          elsif @locale == "RU"
            p generate_ru_data
          elsif @locale == "BY"
            p generate_by_data 
        end
      end
    end

    def generate_us_data
      name = Faker::Name.name
      address = "#{Faker::Address.city} #{Faker::Address.street_address} h.#{Random.rand(40)+1}, #{Faker::AddressUS.state}, #{Faker::AddressUS.zip_code} USA"
      phone_number = Faker::PhoneNumber.phone_number.gsub(' ','-')
      "#{name}; #{address}; #{phone_number}."    
    end

    def generate_ru_data
      name = Ryba::Name.full_name
      address = Ryba::Address.postal
      phone_number = Ryba::PhoneNumber.phone_number.gsub(' ','-')
      "#{name}; #{address}; #{phone_number}."     
    end

    def generate_by_data
      name = Ryba::Name.full_name
      address = by_postal
      phone_number = by_phone_number.gsub(' ','-')
      "#{name}; #{address}; #{phone_number}."     
    end

    def index
      [220000,224000,210000,246000,230000,212000,220017,220136,220019].sample
    end

    def by_phone_number
      "+375 #{[29,33,44,25].sample} #{"%09d" % rand(MAX_PHONE_NUMBER)}"
    end

    def by_city_by_zip(zip)
      by_city = {220000 => 'Минск', 210000 => 'Витебск', 246000 => "Гомель", 230000 =>"Гродно",
        212000 =>"Могилев", 224000 => "Брест", 220017 => "Минск", 220136 => 'Минск', 220019 => 'Минск'}
      by_city[zip]
    end
  
    def by_postal
      zip = index
      "#{Ryba::Address.address}, г. #{by_city_by_zip(zip)}, #{zip}"
    end

    def make_wrong(data_string)
      good_data = Random.rand(10).to_s
      wrong_data = Random.rand(500).to_s
      data_string.gsub(good_data, wrong_data) 
    end
  end
end

user_data = UserData::DataGeneraror.new((ARGV[0]).upcase, (ARGV[1]).to_i, (ARGV[2]).to_f)
user_data.main
