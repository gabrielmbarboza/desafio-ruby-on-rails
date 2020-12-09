FactoryBot.define do
  factory :transaction_type do
    label { Faker::Types.rb_string }
    code { rand(1..100) }
    operation { %w[C D].sample }
  end
end
