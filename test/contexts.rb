# require needed files
require './test/sets/user_contexts'
require './test/sets/ride_contexts'
require './test/sets/pass_type_contexts'
require './test/sets/park_pass_contexts'
require './test/sets/visit_contexts'
require './test/sets/quueue_contexts'


module Contexts
  # explicitly include all sets of contexts used for testing
  include Contexts::UserContexts
  include Contexts::RideContexts
  include Contexts::PassTypeContexts
  include Contexts::ParkPassContexts
  include Contexts::VisitContexts
  include Contexts::QuueueContexts


  def create_unit_test_contexts
    create_users
    puts 'created users'
    create_rides
    puts 'created rides'
    create_pass_types
    puts 'created pass_types'
    create_park_passes
    puts 'created park_passes'
    create_visits
    puts 'created visits'
    create_quueues
    puts 'created quueues'
  end
end
