require 'test_helper'

class PassTypeTest < ActiveSupport::TestCase
  should have_many(:park_passes)
end
