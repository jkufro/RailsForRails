require 'test_helper'

class RideTest < ActiveSupport::TestCase
  should have_many(:quueues)
  
  should allow_value("AAAAD").for(:max_allowed_queue_code)
  should allow_value("AGDES").for(:max_allowed_queue_code)
  should allow_value("ZZZZZ").for(:max_allowed_queue_code)
  should allow_value("IIIII").for(:max_allowed_queue_code)
  should_not allow_value("ASDC").for(:max_allowed_queue_code)
  should_not allow_value("AFDSAD").for(:max_allowed_queue_code)
  should_not allow_value("AAAAa").for(:max_allowed_queue_code)
  should_not allow_value("aFSDW").for(:max_allowed_queue_code)
  should_not allow_value("FFF4W").for(:max_allowed_queue_code)
  should_not allow_value("11111").for(:max_allowed_queue_code)
end
