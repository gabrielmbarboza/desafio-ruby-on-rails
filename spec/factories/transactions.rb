FactoryBot.define do
  factory :transaction do
    amount { Faker::Commerce.price }
    creditcard { Faker::Stripe.valid_card }
    t_date { Faker::Date.in_date_period }
    t_time { Time.now.strftime("%H:%M:%S") }
    store
    customer
    transaction_type
  end
end
