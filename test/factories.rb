FactoryBot.define do

  factory :park_pass do
    first_name "Justin"
    last_name "Kufro"
    card_number ''
    card_expiration 1.year.from_now
    height 58
    association :user
    association :pass_type
  end

  factory :pass_type do
    pass_name "Fun Pass"
    description "Pay for a day, come back all year."
  end

  factory :quueue do
    queue_code ''
    security_code ''
    checked_in false
    association :ride
    association :visit
  end

  factory :ride do
    ride_name 'Montu'
    carts_on_track 2
    cart_occupancy 28
    ride_duration 180
    ride_description "It goes fast!"
    max_allowed_queue_code "AAAA"
    min_height 54
    allow_queue true
    active true
  end

  factory :user do
    username "root"
    password "secret"
    password_confirmation "secret"
    role "admin"
    email { |a| "#{a.username}@example.com".downcase }
    phone { rand(10 ** 10).to_s.rjust(10,'0') }
    active true
  end

  factory :visit do
    visit_date Date.today
    association :park_pass
  end

end
