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


  context "Within context" do
    setup do
      create_unit_test_contexts
    end

    teardown do
      delete_unit_test_contexts
    end

    should "check that the alpabetical scope works as expected" do
      assert_equal(Quueue.alphabetical.length, 3)
      assert_equal(Quueue.alphabetical.map(&:queue_code), ['AAAA', 'AAAA', 'AAAB'])

      @justin_montu_2 = FactoryBot.create(:quueue, ride: @montu, visit: @justin_visit)

      assert_equal(Quueue.alphabetical.length, 4)
      assert_equal(Quueue.alphabetical.map(&:queue_code), ['AAAA', 'AAAA', 'AAAB', 'AAAC'])
    end

    should "check that the are_checked_in scope works as expected" do
      assert_equal(Quueue.are_checked_in.length, 1)
      assert_equal(Quueue.are_checked_in.map(&:queue_code), ['AAAA'])
      assert_equal(Quueue.are_checked_in.map(&:visit), [@justin_visit])
    end

    should "check that the are_not_checked_in scope works as expected" do
      assert_equal(Quueue.are_not_checked_in.length, 2)
      assert_equal(Quueue.alphabetical.are_not_checked_in.map(&:queue_code), ['AAAA', 'AAAB'])
      assert_equal(Quueue.alphabetical.are_not_checked_in.map(&:visit), [@gail_visit, @ashley_visit])
    end

    should "check that the today scope works as expected" do
      assert_equal(Quueue.today.alphabetical.length, 3)
      assert_equal(Quueue.today.alphabetical.map(&:queue_code), ['AAAA', 'AAAA', 'AAAB'])

      justin_montu_2 = FactoryBot.create(:quueue, ride: @montu, visit: @justin_visit)

      assert_equal(Quueue.today.alphabetical.length, 4)
      assert_equal(Quueue.today.alphabetical.map(&:queue_code), ['AAAA', 'AAAA', 'AAAB', 'AAAC'])
    end

    should "check that the on_date scope works as expected" do
      date = Date.yesterday
      assert_equal(Quueue.on_date(date).length, 0)

      @justin_montu.created_at = Date.yesterday.beginning_of_day
      @justin_montu.save(:validate => false)

      assert_equal(Quueue.on_date(date).length, 1)
    end

    should "check that the all_past scope works as expected" do
      assert_equal(Quueue.all_past.length, 0)

      @justin_montu.created_at = Date.yesterday.beginning_of_day
      @justin_montu.save(:validate => false)

      assert_equal(Quueue.all_past.length, 1)

      @ashley_montu.created_at = Date.yesterday.yesterday.beginning_of_day
      @ashley_montu.save(:validate => false)

      assert_equal(Quueue.all_past.length, 2)

      @ashley_montu.created_at = Date.today.beginning_of_day
      @ashley_montu.save(:validate => false)

      assert_equal(Quueue.all_past.length, 1)

      @ashley_montu.created_at = Date.today.beginning_of_day - 1.second
      @ashley_montu.save(:validate => false)

      assert_equal(Quueue.all_past.length, 2)
    end

    should "validate that a rider cannot check in when the queue isn't ready" do
      @ashley_montu.checked_in = true
      deny @ashley_montu.valid?

      @montu.increment_queue
      assert @ashley_montu.valid?
    end

    should "validate that a ride must allow_queue to get in line for it" do
      @justin_scorpion = FactoryBot.build(:quueue, ride: @scorpion, visit: @justin_visit)
      deny @justin_scorpion.valid?

      @scorpion.allow_queue = true
      @scorpion.save

      assert @justin_scorpion.valid?
    end

    should "check that the is_ready? function works as expected" do
      assert @justin_montu.is_ready?
      deny @ashley_montu.is_ready?
      assert @gail_cobras_curse.is_ready?

      @montu.increment_queue
      assert @ashley_montu.is_ready?
    end

    should "check that a queue_code gets generated on queue creation" do
      assert_equal(@justin_montu.queue_code, 'AAAA')
      assert_equal(@gail_cobras_curse.queue_code, 'AAAA')
      assert_equal(@ashley_montu.queue_code, 'AAAB')

      # make a new quueue
      @justin_cobras_curse = FactoryBot.create(:quueue, ride: @cobras_curse, visit: @justin_visit)
      assert_equal(@justin_cobras_curse.queue_code, 'AAAB')
    end

    should "check that a security_code gets generated on queue creation" do
      deny /\A[A-Z]{20}\z/.match(@justin_montu.security_code).nil?
      deny /\A[A-Z]{20}\z/.match(@ashley_montu.security_code).nil?
      deny /\A[A-Z]{20}\z/.match(@gail_cobras_curse.security_code).nil?
    end

    should "validate that a rider cannot be in two lines at once" do
      @ashley_cobras_curse = FactoryBot.build(:quueue, ride: @cobras_curse, visit: @ashley_visit)
      deny @ashley_cobras_curse.valid?
    end
  end
end
