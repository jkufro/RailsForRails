namespace :db do
  desc "Erase and fill database"
  # creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
  task :populate => :environment do
    # Drop the old db and recreate from scratch
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    # Invoke rake db:migrate
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:test:prepare'].invoke

    # Docs at: http://faker.rubyforge.org/rdoc/
    require 'faker'
    require 'factory_bot_rails'

    # Step 1: Create some rides
    montu = FactoryBot.create(:ride)
    sheikra = FactoryBot.create(:ride, ride_name: 'SheiKra', carts_on_track: 3, cart_occupancy: 24, ride_duration: 140, ride_description: 'No Floors!')
    cobras_curse = FactoryBot.create(:ride, ride_name: "Cobra's Curse", carts_on_track: 8, cart_occupancy: 4, ride_duration: 180, ride_description: 'Spin!', min_height: 48)
    cheetah_hunt = FactoryBot.create(:ride, ride_name: 'Cheetah Hunt', carts_on_track: 5, cart_occupancy: 16, ride_duration: 210, ride_description: 'Channel your inner cheetah!', min_height: 48)
    sand_serpent = FactoryBot.create(:ride, ride_name: 'Sand Serpent', carts_on_track: 5, cart_occupancy: 4, ride_duration: 120, ride_description: 'Watch for the tight corners!', min_height: 48)
    kumba = FactoryBot.create(:ride, ride_name: 'Kumba', carts_on_track: 3, cart_occupancy: 16, ride_duration: 174, ride_description: "Had the world's tallest vertical loop!")
    scorpion = FactoryBot.create(:ride, ride_name: 'Scorpion', carts_on_track: 1, cart_occupancy: 16, ride_duration: 60, ride_description: 'Try out the loop!', min_height: 48, allow_queue: false)
    gwazi = FactoryBot.create(:ride, ride_name: 'Gwazi', carts_on_track: 4, cart_occupancy: 24, ride_duration: 150, ride_description: 'Permanently closed wooden coaster.', min_height: 48, allow_queue: false, active: false)
    puts("Created Rides\n")


    # Step 2: Create some users
    admin = FactoryBot.create(:user)
    justin = FactoryBot.create(:user, username: 'jkufro', role: 'visitor')
    tyler = FactoryBot.create(:user, username: 'tkufro', role: 'visitor')
    gail = FactoryBot.create(:user, username: 'gkufro', role: 'visitor')
    puts("Created Users\n")


    # Step 3: Create some pass types
    fun_pass = FactoryBot.create(:pass_type)
    annual_pass = FactoryBot.create(:pass_type, pass_name: 'Annual Pass', description: 'Pay each month and get great park benefits')
    puts("Created Pass Types\n")


    # Step 4: Create some park passes
    justin_fun_pass = FactoryBot.create(:park_pass, card_expiration: Date.new(Date.today.year + 1,12,31), user: justin, pass_type: fun_pass)
    ashley_fun_pass = FactoryBot.create(:park_pass, first_name: 'Ashley', last_name: 'Haenig', card_expiration: Date.new(Date.today.year + 1,12,31), user: justin, pass_type: fun_pass)
    tyler_annual_pass = FactoryBot.create(:park_pass, first_name: 'Tyler', user: tyler, pass_type: annual_pass)
    gail_fun_pass = FactoryBot.create(:park_pass, first_name: 'Gail', last_name: 'Kufro', user: gail, pass_type: fun_pass)
    joe_fun_pass = FactoryBot.create(:park_pass, first_name: 'Joe', last_name: 'Kufro', user: gail, pass_type: fun_pass)
    puts("Created Park Passes\n")


    # Step 5: Create some visits
    justin_visit = FactoryBot.create(:visit, park_pass: justin_fun_pass)
    ashley_visit = FactoryBot.create(:visit, park_pass: ashley_fun_pass)
    gail_visit = FactoryBot.create(:visit, park_pass: gail_fun_pass)
    puts("Created Visits\n")


    # Step 6: Create some quueues
    justin_montu = FactoryBot.create(:quueue, ride: montu, visit: justin_visit, checked_in: true)
    ashley_montu = FactoryBot.create(:quueue, ride: montu, visit: ashley_visit)
    justin_sheikra = FactoryBot.create(:quueue, ride: sheikra, visit: justin_visit)
    gail_cobras_curse = FactoryBot.create(:quueue, ride: cobras_curse, visit: gail_visit)
    puts("Created Quueues\n")
  end
end
