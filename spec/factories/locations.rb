FactoryBot.define do
  factory :location do
    name { Faker::RickAndMorty.location }
    address { Faker::Address.street_address }
    address_2 { Faker::Address.secondary_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Address.zip }
  end

  factory :seattle_location, class: Location do
    name { Faker::RickAndMorty.location }
    address '721 Pine St'
    city 'Seattle'
    state 'WA'
  end
end