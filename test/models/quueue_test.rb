require 'test_helper'

class QuueueTest < ActiveSupport::TestCase
  should belong_to(:ride)
  should belong_to(:visit)

  should allow_value("AAAA").for(:queue_code)
  should allow_value("AGDS").for(:queue_code)
  should allow_value("ZZZZ").for(:queue_code)
  should allow_value("IIII").for(:queue_code)
  should_not allow_value("ASDCC").for(:queue_code)
  should_not allow_value("AFDSAD").for(:queue_code)
  should_not allow_value("AAAAa").for(:queue_code)
  should_not allow_value("aFSDW").for(:queue_code)
  should_not allow_value("FFF4W").for(:queue_code)
  should_not allow_value("11111").for(:queue_code)
  should_not allow_value("AAA").for(:queue_code)

  should validate_presence_of(:ride_id)
  should validate_presence_of(:visit_id)
  should validate_presence_of(:queue_code)
  should validate_presence_of(:security_code)

  should "check that the alpabetical scope works as expected" do

  end

  should "check that the are_checked_in scope works as expected" do

  end

  should "check that the are_not_checked_in scope works as expected" do

  end

  should "check that the today scope works as expected" do

  end

  should "check that the on_date scope works as expected" do

  end

  should "check that the all_past scope works as expected" do

  end

  should "validate that a rider cannot check in when the queue isn't ready" do

  end

  should "validate that a ride must allow_queue to get in line for it" do

  end

  should "check that the is_ready? function works as expected" do

  end

  should "check that a queue_code gets generated only on queue creation" do

  end

  should "check that a security_code gets generated only on queue creation" do

  end
end
