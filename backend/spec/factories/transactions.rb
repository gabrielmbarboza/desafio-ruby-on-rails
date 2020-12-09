FactoryBot.define do
  factory :transaction do
    amount { Faker::Commerce.price }
    creditcard { Faker::Stripe.valid_card }
    performed_at { Faker::Time.between_dates(from: Date.today - 1, to: Date.today, period: :all) }
    store
    customer
    transaction_type
  end
end
