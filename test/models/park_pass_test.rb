require 'test_helper'

class ParkPassTest < ActiveSupport::TestCase
  should belong_to(:pass_type)
  should belong_to(:user)
  should have_many(:visits)
  should have_many(:quueues).through(:visits)

  should allow_value("V761997609331450").for(:card_number)
  should allow_value("P657816359167903").for(:card_number)
  should allow_value("K100983943647243").for(:card_number)
  should allow_value("P969196322550527").for(:card_number)
  should_not allow_value("4969196322550527").for(:card_number)
  should_not allow_value("P96919632255052A").for(:card_number)
  should_not allow_value("P9691963225505274").for(:card_number)
  should_not allow_value("P96919632255527").for(:card_number)
  should_not allow_value("p96919632255527").for(:card_number)

  should validate_presence_of(:user_id)
  should validate_presence_of(:pass_type_id)
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  should validate_presence_of(:card_number)
  should validate_presence_of(:card_expiration)


  # test creating passes with different expiration dates

  # test expired function
end
