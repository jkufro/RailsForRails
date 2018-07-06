namespace :db do
  desc "Fill the park with visits and queues"
  # creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
  task :park_day => :environment do

    # Docs at: http://faker.rubyforge.org/rdoc/
    require 'faker'
    require 'factory_bot_rails'

    # Step 1: Generate some visits
    generated_visits = []
    passes = ParkPass.all
    sampled_passes = passes.sample([2250, passes.length].min)
    sampled_passes.each do |pass|
        generated_visits << FactoryBot.create(:visit, park_pass: pass)
    end
    puts("Created Visits\n")

    # Step 2: Get rideable rides
    queueable_rides = Ride.all.active.allow_queue

    # Step 2: Generate some quueues
    generated_quueues = []
    sampled_visits = generated_visits.sample([2000, generated_visits.length].min)
    sampled_visits.each do |visit|
        ride = queueable_rides.sample(1).first
        generated_quueues << FactoryBot.create(:quueue, ride: ride, visit: visit)
    end
    puts("Created Quueues\n")
  end
end
