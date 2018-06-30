require 'test_helper'

class RideTest < ActiveSupport::TestCase
  should have_many(:quueues)

  should allow_value("AAAA").for(:max_allowed_queue_code)
  should allow_value("AGDS").for(:max_allowed_queue_code)
  should allow_value("ZZZZ").for(:max_allowed_queue_code)
  should allow_value("IIII").for(:max_allowed_queue_code)
  should_not allow_value("ASDCF").for(:max_allowed_queue_code)
  should_not allow_value("ASF").for(:max_allowed_queue_code)
  should_not allow_value("AFDSAD").for(:max_allowed_queue_code)
  should_not allow_value("AAAAa").for(:max_allowed_queue_code)
  should_not allow_value("aFSDW").for(:max_allowed_queue_code)
  should_not allow_value("FFF4W").for(:max_allowed_queue_code)
  should_not allow_value("11111").for(:max_allowed_queue_code)

  should validate_numericality_of(:carts_on_track).is_greater_than_or_equal_to(0).only_integer
  should validate_numericality_of(:ride_duration).is_greater_than(0).only_integer
  should validate_numericality_of(:cart_occupancy).is_greater_than(0).only_integer
  should validate_numericality_of(:min_height).is_greater_than(0).only_integer

  should validate_presence_of(:ride_name)
  should validate_presence_of(:carts_on_track)
  should validate_presence_of(:ride_duration)
  should validate_presence_of(:cart_occupancy)
  should validate_presence_of(:max_allowed_queue_code)
  should validate_presence_of(:min_height)

  # set up context
  context "Within context" do
    setup do
      create_unit_test_contexts
    end

    teardown do
      delete_unit_test_contexts
    end

    should "validate that a ride must be active to allow new queues" do
      bad_queue = FactoryBot.build(:quueue, ride: @scorpion, visit: @justin_visit)
      deny bad_queue.valid?
    end

    should "increment_queue function should work as expected" do
      assert @montu.max_allowed_queue_code == 'AAAA'
      @montu.increment_queue
      assert @montu.max_allowed_queue_code == 'AAAB'
    end

    should "call_queue function should work as expected" do
      assert @montu.max_allowed_queue_code == 'AAAA'
      @montu.call_queue(1)
      assert @montu.max_allowed_queue_code == 'AAAB'
      @montu.call_queue(5)
      assert @montu.max_allowed_queue_code == 'AAAG'
    end

    should "reset_queue function should work as expected" do
      assert @montu.max_allowed_queue_code == 'AAAA'
      @montu.increment_queue
      assert @montu.max_allowed_queue_code == 'AAAB'
      @montu.reset_queue
      assert @montu.max_allowed_queue_code == 'AAAA'
    end

    should "ready queues function should work as expected" do
      assert_equal(@montu.ready_queues.length, 1)
      @montu.increment_queue
      assert_equal(@montu.ready_queues.length, 2)
      assert_equal(@cobras_curse.ready_queues.length, 1)
      assert_equal(@sheikra.ready_queues.length, 0)
    end

    should "unready queues function should work as expected" do
      assert_equal(@montu.unready_queues.length, 1)
      @montu.increment_queue
      assert_equal(@montu.unready_queues.length, 0)
      assert_equal(@cobras_curse.unready_queues.length, 0)
      assert_equal(@sheikra.unready_queues.length, 0)
    end

    should "not allow queues to be created for rides that do not allow_queue" do
      bad_queue = FactoryBot.build(:quueue, ride: @cheetah_chase, visit: @justin_visit)
      deny bad_queue.valid?
    end

    should "ride must be active to have allow_queue set to true" do
      assert @cheetah_chase.valid?
      @cheetah_chase.allow_queue = true
      deny @cheetah_chase.valid?
    end
  end
end
