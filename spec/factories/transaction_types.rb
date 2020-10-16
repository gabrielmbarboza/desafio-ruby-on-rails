FactoryBot.define do
  factory :transaction_type do
    name { Faker::Types.rb_string }
    operation { %w[C D].sample }
  end
end
