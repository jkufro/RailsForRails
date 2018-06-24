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
end
