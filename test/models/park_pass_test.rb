require 'test_helper'

class ParkPassTest < ActiveSupport::TestCase
  should belong_to(:pass_type)
  should belong_to(:user)
  should have_many(:visits)
  should have_many(:quueues).through(:visits)
end
