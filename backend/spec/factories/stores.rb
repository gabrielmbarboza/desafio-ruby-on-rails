FactoryBot.define do
  factory :store do
    name { Faker::Company.name }
    owner { Faker::Name.name }
  end
end
