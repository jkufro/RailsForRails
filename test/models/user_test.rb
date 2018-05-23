require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:park_passes)
end
