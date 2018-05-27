require 'test_helper'

class QuueueTest < ActiveSupport::TestCase
  should belong_to(:ride)
  should belong_to(:visit)
  
  should allow_value("AAAAD").for(:queue_code)
  should allow_value("AGDES").for(:queue_code)
  should allow_value("ZZZZZ").for(:queue_code)
  should allow_value("IIIII").for(:queue_code)
  should_not allow_value("ASDC").for(:queue_code)
  should_not allow_value("AFDSAD").for(:queue_code)
  should_not allow_value("AAAAa").for(:queue_code)
  should_not allow_value("aFSDW").for(:queue_code)
  should_not allow_value("FFF4W").for(:queue_code)
  should_not allow_value("11111").for(:queue_code)
end
