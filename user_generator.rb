require 'ffaker'
require 'ryba'


lang = (ARGV[0])
N = (ARGV[1]).to_i
miss_perc = (ARGV[2])
  
@names = []
@addresses = []
@phone_numberes = []

N.times do
	if lang == "US"	
      
      @names << name 
      address = "#{Faker::Address.city} #{Faker::Address.street_address} #{Random.rand(40)+1}"
      @addresses << address
      phone_number = "#{Faker::PhoneNumber.phone_number}"
      @phone_numberes << phone_number
      p "#{name}; #{address}; #{phone_number}."
    elsif lang == "RU"
      name = Ryba::Name.full_name
      @names <<  name
      address = Ryba::Address.postal
      @addresses << address 
      phone_number = Ryba::PhoneNumber.phone_number
      @phone_numberes << phone_number
      p "#{name}; #{address}; #{phone_number}."
  end
end


def gen_us
  name = Faker::Name.name
  address = "#{Faker::Address.city} #{Faker::Address.street_address} #{Random.rand(40)+1}"
  phone_number = Faker::PhoneNumber.phone_number
  us_user = "#{name}; #{address}; #{phone_number}."     
end

def gen_ru
  name = Ryba::Name.full_name
  address = Ryba::Address.postal
  phone_number = Ryba::PhoneNumber.phone_number
  ru_user = "#{name}; #{address}; #{phone_number}."     
end

=begin
p @name.to_s
p @address
p @phone_number.to_s
=end
