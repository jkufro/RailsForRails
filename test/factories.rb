FactoryBot.define do

  factory :park_pass do
    first_name "justin"
    last_name "kufro"
    card_number { "A" + rand(10 ** 14).to_s.rjust(10,'0') }
    card_expiration 1.year.from_now
    height 58
    association :user
    association :pass_type
  end

  factory :pass_type do
    name "Fun Pass"
    description "Pay for a day, come back all year."
  end

  factory :quueue do
    queue_code { Array.new(5){[*"A".."Z"].sample}.join }
    security_code { Array.new(20){[*"A".."Z"].sample}.join }
    checked_in false
    association :ride
    association :visit
  end

  factory :ride do
    carts_on_track 2
    cart_occupancy 16
    ride_duration 60
    ride_description "It goes fast!"
    max_allowed_queue_code "AAAAA"
    min_height 48
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
