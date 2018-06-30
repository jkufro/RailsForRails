require 'test_helper'

class VisitTest < ActiveSupport::TestCase
  should have_many(:quueues)
  should belong_to(:park_pass)
  should validate_presence_of(:visit_date)
  should validate_presence_of(:park_pass_id)

  should allow_value(Date.today).for(:visit_date)
  should allow_value(10.minutes.from_now).for(:visit_date)
  should allow_value(Date.tomorrow - 5.minutes).for(:visit_date)
  should_not allow_value(Date.tomorrow + 5.minutes).for(:visit_date)
  should_not allow_value(25.hours.from_now).for(:visit_date)
  should_not allow_value(25.hours.ago).for(:visit_date)
  should_not allow_value(Date.yesterday).for(:visit_date)

  # set up context
  context "Within context" do
    setup do
      create_unit_test_contexts
    end

    teardown do
      delete_unit_test_contexts
    end

    should "validate that the today scope works as expected" do
      assert_equal(Visit.today.length, 3)
    end

    should "validate the timeliness of visit_date on create" do
      bad_visit = FactoryBot.build(:visit, park_pass: @joe_fun_pass, visit_date: Date.yesterday)
      deny bad_visit.valid?

      assert @justin_visit.valid?
      @justin_visit.visit_date = Date.yesterday
      assert @justin_visit.valid?
    end

    should "show that expired passes cannot visit" do
      @joe_fun_pass.card_expiration = Date.yesterday
      @joe_fun_pass.save
      bad_visit = FactoryBot.build(:visit, park_pass: @joe_fun_pass)
      deny bad_visit.valid?
    end

    should "show that the ridden_rides function works as expected" do
      assert_equal(@justin_visit.ridden_rides, [@montu])
      assert_equal(@gail_visit.ridden_rides, [])
    end

    should "show that the ridden_rides_summary function works as expected" do
      assert_equal(@justin_visit.ridden_rides_summary, {@montu.ride_name => 1})
      assert_equal(@gail_visit.ridden_rides_summary, {})
    end

    should "show that the current_queue function works as expected" do
      assert_nil @justin_visit.current_queue
      assert_equal(@ashley_visit.current_queue.ride, @montu)
      assert_equal(@gail_visit.current_queue.ride, @cobras_curse)
    end
  end
end
