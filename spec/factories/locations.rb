FactoryBot.define do
  factory :location do
    name { Faker::RickAndMorty.location }
    address { Faker::Address.street_address }
    address_2 { Faker::Address.secondary_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Address.zip }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end