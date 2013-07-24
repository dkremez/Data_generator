# coding: utf-8
require 'rspec'
require_relative 'spec_helper'
require_relative '../user_data'

describe UserData do

  it 'should exists' do
    UserData::DataGenetaror.new('us', '1', '0')
  end 

  describe "#generate_##_data" do

    it "generate us  user data " do
      user = UserData::DataGenetaror.new('us', '1', '0')
      expect(user.generate_us_data).to match(/^(.*;.*;.*)$/)
    end

    it "generate ru user data" do
      user = UserData::DataGenetaror.new('ru', '1', '0')
      expect(user.generate_ru_data).to match(/^(.*;.*;.*)$/)
    end

    it "generate by user data" do
      user = UserData::DataGenetaror.new('by', '1', '0')
      expect(user.generate_by_data).to match(/^(.*;.*;.*)$/)
    end

  end

  it "give Belarusian index" do
    user = UserData::DataGenetaror.new('by', '1', '0')
    expect(user.index.to_s).to match(/^[2]{1}[0-9]{5}$/)
  end

  it "return Belarussian postal data" do
    user = UserData::DataGenetaror.new('by', '1', '0')
    expect(user.by_postal).to match(/^(.*,.*,.*)$/)
  end

  it "return Belarussian phone number" do
    user = UserData::DataGenetaror.new('by', '1', '0')
    expect(user.by_phone_number.to_s).to match(/^\+375 [0-9]{2} [0-9]{7}$/)
  end

  it "give Minsk city by zipcode" do
    user = UserData::DataGenetaror.new('by', '1', '0')
    user.by_city_by_zip(220000).should eq('Минск')
  end
 

end