# coding: utf-8
require 'ffaker'
require 'ryba'


lang = (ARGV[0])
N = (ARGV[1]).to_i
miss_perc = (ARGV[2]).to_f

def gen_us
  name = Faker::Name.name
  address = "#{Faker::AddressUS.zip_code}, #{Faker::AddressUS.state}, #{Faker::Address.city} #{Faker::Address.street_address} h.#{Random.rand(40)+1}"
  phone_number = Faker::PhoneNumber.phone_number
  "#{name}; #{address}; #{phone_number}."    
end

def gen_ru
  name = Ryba::Name.full_name
  address = Ryba::Address.postal
  phone_number = Ryba::PhoneNumber.phone_number
  "#{name}; #{address}; #{phone_number}."     
end

def gen_by
  name = Ryba::Name.full_name
  address = by_postal
  phone_number = by_phone_number
  "#{name}; #{address}; #{phone_number}."     
end

def index
  [220000,224000,210000,246000,230000,212000].sample
end

def by_phone_number
  "+375 #{[29,33,44,25].sample} #{(0000000..9999999).to_a.sample}"
end
def by_city_by_zip(zip)
  by_city = {220000 => 'Минск', 210000 => 'Витебск', 246000 => "Гомель", 230000 =>"Гродно", 212000 =>"Могилев", 224000 => "Брест"}
  by_city[zip]
end


  
def by_postal
  zip = index
  "#{zip}, #{by_city_by_zip(zip)}, #{Ryba::Address.address}"
end



# def by_city(zip) 
#   case zip
#       when 220000
#         'Минск'
#       when 210000
#         'Витебск'
#       when 246000
#         'Гомель'
#       when 230000
#         'Гродно'
#       when 212000
#         'Могилев'
#       when 224000
#         'Брест'
#       else
#         'Минск'
#   end
# end

(N*miss_perc).to_i.times do
  it_was = Random.rand(10).to_s
  it_will_be = Random.rand(500).to_s
	if lang == "US"
      p gen_us.gsub(it_was, it_will_be) 
    elsif lang == "RU"
      p gen_ru.gsub(it_was, it_will_be) 
    elsif lang == "BY"
      p gen_by.gsub(it_was, it_will_be) 
  end
end

(N-N*miss_perc).to_i.times do
  if lang == "US"
      p gen_us
    elsif lang == "RU"
      p gen_ru
    elsif lang == "BY"
      p gen_by 
  end
end


