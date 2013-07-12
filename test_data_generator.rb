require 'ffaker'

lang = (ARGV[0])
N = (ARGV[1]).to_i
miss_perc = (ARGV[2])

@name = []
@address = []
@phone_number = []

N.times do
	if lang == "en"	 
      @name << "#{Faker::Name.name}" 
      @address <<   "#{Faker::Address.city} #{Faker::Address.street_address} #{Random.rand(40)+1}"
      @phone_number << "#{Faker::PhoneNumber.phone_number}"
    elsif lang == "ru"
      @name << Faker::NameRU.name 
      @address <<  "#{Faker::Address.city} #{Faker::Address.street_address} #{Random.rand(40)+1}"
      @phone_number << Faker::PhoneNumber.phone_number
  end
end

p @name.to_s
p @address
p @phone_number.to_s