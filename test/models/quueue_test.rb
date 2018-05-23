require 'test_helper'

class QuueueTest < ActiveSupport::TestCase
  should belong_to(:ride)
  should belong_to(:visit)
end
