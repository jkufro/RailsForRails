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
  
  should validate_numericality_of(:carts_on_track) 
  should allow_value(1).for(:carts_on_track)
  should allow_value(100).for(:carts_on_track)
  should allow_value(60).for(:carts_on_track)
  should allow_value(22.0).for(:carts_on_track)
  should_not allow_value(0.1).for(:carts_on_track)
  should_not allow_value(-0.1).for(:carts_on_track)
  should_not allow_value(-1).for(:carts_on_track)
  should_not allow_value(20.0000001).for(:carts_on_track)
  
  
end
