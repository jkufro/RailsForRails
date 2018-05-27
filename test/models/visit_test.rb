require 'test_helper'

class VisitTest < ActiveSupport::TestCase
  should have_many(:quueues)
  should belong_to(:park_pass)
  
  should allow_value(Date.today).for(:visit_date)
  should allow_value(10.minutes.from_now).for(:visit_date)
  should allow_value(Date.tomorrow - 5.minutes).for(:visit_date)
  should_not allow_value(Date.tomorrow + 5.minutes).for(:visit_date)
  should_not allow_value(25.hours.from_now).for(:visit_date)
  should_not allow_value(25.hours.ago).for(:visit_date)
  should_not allow_value(Date.yesterday).for(:visit_date)
end
