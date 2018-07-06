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
    montu_desc = "Florida’s favorite inverted coaster! Intense thrills meet smooth-as-silk steel on this classic, a favorite of coaster enthusiasts for its speeds and inversions.  Whether you speak coaster or not, come see why Montu® means thrills to roller coaster enthusiasts in any language."
    sheikra_desc = "200-foot tall floorless dive coaster! Climb 200 feet to the edge of a 90-degree drop that inches you mercilessly over the edge—and stops. Then surrender to speed as you dive straight down into a 70 mph roller coaster whirlwind with an Immelmann loop, a second dive into an underground tunnel and a splashdown finale that drenches SheiKra® fans waiting to catch their own piece of the fun."
    cobras_curse_desc = "Florida's first family spin coaster! This one-of-a-kind roller coaster features a menacing 30,000-pound snake king and a 70-foot vertical lift that will take riders within inches of its 3 foot-wide eyes and 4-foot-long fangs. During the three-and-a-half-minute ride, the coaster trains speed along at 40 mph down 2,100 feet of serpentine-like track, traveling backward, forward and then spinning freely."
    cheetah_hunt_desc = "Thrilling triple-launch roller coaster. A celebration of the fastest land animal, Tampa Bay’s longest roller coaster quickly raced and weaved its way onto the list of coaster favorites. This triple launch roller coaster carries riders high above the park, then races down along the ground through a rocky gorge. At a length of 4,400 feet, Cheetah Hunt® is the park’s longest thrill ride attraction!"
    sand_serpent_desc = 'Wild adventure 5 stories high! Families will love the curves, drops, and corkscrews of this "wild-mouse" style roller coaster located in the Pantopia® area of the park. SandSerpent is a fun-filled family coaster that zips, zooms and climbs five stories into the air before bringing riders back down in a roar of laughter.'
    kumba_desc = "Legendary steel coaster that roars! Named for the distant roar of the king of the jungle, see why this legendary roller coaster still reigns on so many lists of favorites. After the thrill of an initial 135 foot drop, you will plunge into a diving loop, feel a full 3 seconds of absolute weightlessness while spiraling 360 degrees!"
    scorpion_desc = "360-degree vertical loop, upside down! The Scorpion® is one of only three roller coasters of its kind remaining in the world today, yet its sting is every bit as effective at instilling thrills through every twist and turn. Scorpion pulls you through a 360 degree loop and speeds of 50 miles per hour!"

    montu_image = 'https://buschgardens.com/handlers/ImageResizer.ashx?path=https%3A%2F%2Fseaworld.scdn3.secure.raxcdn.com%2Ftampa%2F-%2Fmedia%2Fbusch-gardens-tampa%2Fmedia-modules%2F750x422%2Frides%2Fmontu%2F2017_buschgardenstampabay_rollercoasters_montu4_750x422.ashx%3Fversion%3D1_201704175933&w=750'
    sheikra_image = 'https://buschgardens.com/handlers/ImageResizer.ashx?path=https%3A%2F%2Fseaworld.scdn3.secure.raxcdn.com%2Ftampa%2F-%2Fmedia%2Fbusch-gardens-tampa%2Fmedia-modules%2F750x422%2Frides%2Fsheikra%2F2017_buschgardenstampabay_rollercoasters_sheikra4_mediamodule_750x422.ashx%3Fversion%3D1_201704174842&w=750'
    cobras_curse_image = 'https://buschgardens.com/handlers/ImageResizer.ashx?path=https%3A%2F%2Fseaworld.scdn3.secure.raxcdn.com%2Ftampa%2F-%2Fmedia%2Fbusch-gardens-tampa%2Fmedia-modules%2F750x422%2Frides%2Fcobras-curse%2F2017_buschgardenstampabay_rollercoasters_cobrascurse8_750x422.ashx%3Fversion%3D1_201704141748&w=750'
    cheetah_hunt_image = 'https://buschgardens.com/handlers/ImageResizer.ashx?path=https%3A%2F%2Fseaworld.scdn3.secure.raxcdn.com%2Ftampa%2F-%2Fmedia%2Fbusch-gardens-tampa%2Fmedia-modules%2F750x422%2Frides%2Fcheetah-hunt%2F2017_buschgardenstampabay_rollercoasters_cheetahhunt3_750x422.ashx%3Fversion%3D1_201704174136&w=750'
    sand_serpent_image = 'http://www.coastergallery.com/2000/Wild_Mouse_Hersheypark-5.jpg'
    kumba_image = 'https://buschgardens.com/handlers/ImageResizer.ashx?path=https%3A%2F%2Fseaworld.scdn3.secure.raxcdn.com%2Ftampa%2F-%2Fmedia%2Fbusch-gardens-tampa%2Fmedia-modules%2F740x442%2Frides%2Fkumba%2F2017_buschgardenstampabay_rollercoasters_kumba6_740x442.ashx%3Fversion%3D1_201705261916&w=750'
    scorpion_image = 'https://coasterbuzz.com/CoasterPhoto/CoasterPhotoImage/3097'
    gwazi_image = 'http://www.tampabay.com/storyimage/HI/20141223/ARTICLE/312239608/EP/1/1/EP-312239608.jpg?cachebuster=851339'

    montu = FactoryBot.create(:ride, ride_description: montu_desc, ride_image_url: montu_image)
    sheikra = FactoryBot.create(:ride, ride_image_url: sheikra_image, ride_name: 'SheiKra', carts_on_track: 3, cart_occupancy: 24, ride_duration: 140, ride_description: sheikra_desc)
    cobras_curse = FactoryBot.create(:ride, ride_image_url: cobras_curse_image, ride_name: "Cobra's Curse", carts_on_track: 8, cart_occupancy: 4, ride_duration: 180, ride_description: cobras_curse_desc, min_height: 48)
    cheetah_hunt = FactoryBot.create(:ride, ride_image_url: cheetah_hunt_image, ride_name: 'Cheetah Hunt', carts_on_track: 5, cart_occupancy: 16, ride_duration: 210, ride_description: cheetah_hunt_desc, min_height: 48)
    sand_serpent = FactoryBot.create(:ride, ride_image_url: sand_serpent_image, ride_name: 'Sand Serpent', carts_on_track: 5, cart_occupancy: 4, ride_duration: 120, ride_description: sand_serpent_desc, min_height: 48)
    kumba = FactoryBot.create(:ride, ride_image_url: kumba_image, ride_name: 'Kumba', carts_on_track: 3, cart_occupancy: 16, ride_duration: 174, ride_description: kumba_desc)
    scorpion = FactoryBot.create(:ride, ride_image_url: scorpion_image, ride_name: 'Scorpion', carts_on_track: 1, cart_occupancy: 16, ride_duration: 60, ride_description: scorpion_desc, min_height: 48, allow_queue: false)
    gwazi = FactoryBot.create(:ride, ride_image_url: gwazi_image, ride_name: 'Gwazi', carts_on_track: 4, cart_occupancy: 24, ride_duration: 150, ride_description: 'Permanently closed wooden coaster.', min_height: 48, allow_queue: false, active: false)
    queueable_rides = [montu, sheikra, cobras_curse, cheetah_hunt, sand_serpent, kumba]
    puts("Created Rides\n")


    # Step 2: Create some pass types
    fun_pass = FactoryBot.create(:pass_type)
    annual_pass = FactoryBot.create(:pass_type, pass_name: 'Annual Pass', description: 'Pay each month and get great park benefits')
    puts("Created Pass Types\n")


    # Step 3: Create some users
    admin = FactoryBot.create(:user)
    justin = FactoryBot.create(:user, username: 'jkufro', role: 'visitor')
    tyler = FactoryBot.create(:user, username: 'tkufro', role: 'visitor')
    gail = FactoryBot.create(:user, username: 'gkufro', role: 'visitor')
    # make some generated users
    generated_users = []
    generated_passes = []
    1500.times do
        last_name = Faker::Name.last_name
        first_name = Faker::Name.first_name
        username = "#{first_name}_#{last_name}#{rand(9999)}"
        user = FactoryBot.create(:user, username: username, role: 'visitor')
        generated_users << user

        # make some passes for the users
        pass = FactoryBot.create(:park_pass, first_name: first_name, last_name: last_name, card_expiration: Date.new(Date.today.year + 1,12,31), user: user, pass_type: fun_pass)
        generated_passes << pass
        num_passes = rand(5)
        num_passes.times do
            first_name = Faker::Name.first_name
            pass = FactoryBot.create(:park_pass, first_name: first_name, last_name: last_name, card_expiration: Date.new(Date.today.year + 1,12,31), user: user, pass_type: fun_pass)
            generated_passes << pass
        end
    end
    puts("Created Users\n")


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

    # generate some visits
    generated_visits = []
    sampled_passes = generated_passes.sample([2250, generated_passes.length].min)
    sampled_passes.each do |pass|
        generated_visits << FactoryBot.create(:visit, park_pass: pass)
    end
    puts("Created Visits\n")


    # Step 6: Create some quueues
    justin_montu = FactoryBot.create(:quueue, ride: montu, visit: justin_visit, checked_in: true)
    ashley_montu = FactoryBot.create(:quueue, ride: montu, visit: ashley_visit)
    gail_cobras_curse = FactoryBot.create(:quueue, ride: cobras_curse, visit: gail_visit)
    # generate some quueues
    generated_quueues = []
    sampled_visits = generated_visits.sample([2000, generated_visits.length].min)
    sampled_visits.each do |visit|
        ride = queueable_rides.sample(1).first
        generated_quueues << FactoryBot.create(:quueue, ride: ride, visit: visit)
    end
    justin_sheikra = FactoryBot.create(:quueue, ride: sheikra, visit: justin_visit)
    puts("Created Quueues\n")
  end
end
