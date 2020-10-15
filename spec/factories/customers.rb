FactoryBot.define do
  factory :customer do
    itr { Faker::IDNumber.brazilian_citizen_number }
  end
end
