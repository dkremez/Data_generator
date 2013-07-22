# coding: utf-8
require 'ffaker'
require 'ryba'


lang = (ARGV[0]).upcase
N = (ARGV[1]).to_i
miss_perc = (ARGV[2]).to_f
MAX_NUMBER = 9999999

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
  "+375 #{[29,33,44,25].sample} #{"%09d" % rand(MAX_NUMBER)}"
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

(N*miss_perc).to_i.times do
  
	if lang == "US"
      p make_wrong generate_us_data 
    elsif lang == "RU"
      p make_wrong generate_ru_data 
    elsif lang == "BY"
      p make_wrong generate_by_data
  end
end

(N-N*miss_perc).to_i.times do
  if lang == "US"
      p generate_us_data
    elsif lang == "RU"
      p generate_ru_data
    elsif lang == "BY"
      p generate_by_data 
  end
end


