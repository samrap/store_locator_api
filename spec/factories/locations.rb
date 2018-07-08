FactoryBot.define do
  factory :location do
    name { Faker::RickAndMorty.location }
  end
end