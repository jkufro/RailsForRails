require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:park_passes)
  should have_secure_password
end
