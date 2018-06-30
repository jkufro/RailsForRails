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

  should validate_uniqueness_of(:card_number)

  # test creating passes with different expiration dates
  should allow_value(Date.tomorrow).for(:card_expiration)
  should allow_value(10.days.from_now).for(:card_expiration)
  should allow_value(Date.today).for(:card_expiration)
  should_not allow_value(Date.yesterday).for(:card_expiration)
  should_not allow_value(10.days.ago).for(:card_expiration)

  context "Within context" do
    setup do
      create_unit_test_contexts
    end

    teardown do
      delete_unit_test_contexts
    end

    should "check that the expired? method works as expected" do
      deny @justin_fun_pass.expired?
      deny @ashley_fun_pass.expired?
      deny @gail_fun_pass.expired?
      @justin_fun_pass.card_expiration = Date.yesterday
      @justin_fun_pass.save
      assert @justin_fun_pass.expired?
    end

    should "check that the ridden_rides method works as expected" do

    end

    should "check that the ridden_rides_summary method works as expected" do

    end

    should "check that the at_park? method works as expected" do

    end

    should "check that the create_card_number method works as expected" do

    end
  end
end
