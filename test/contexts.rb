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
    create_rides
    create_pass_types
    create_park_passes
    create_visits
    create_quueues
  end

  def delete_unit_test_contexts
    delete_quueues
    delete_visits
    delete_park_passes
    delete_pass_types
    delete_users
    delete_rides
  end
end
