require 'rails_helper'

RSpec.describe Customer, type: :model do
  let(:customer1) { create(:customer) }

  it "Should be valid" do
    expect(customer1).to be_valid
  end

  it "Should not be valid, irt (individual taxpayer registration) is not present" do
    customer2 = build(:customer, itr: nil)
    expect(customer2).to_not be_valid
  end

  it "Should not be valid, irt is too long" do
    customer2 = build(:customer, itr: Faker::Number.leading_zero_number(digits: 12))
    expect(customer2).to_not be_valid
  end

  it "Should not be valid, irt is too short" do
    customer2 = build(:customer, itr: Faker::Number.leading_zero_number(digits: 10))
    expect(customer2).to_not be_valid
  end

  it "Should not be valid, irt whit invalid format" do
    customer2 = build(:customer, itr: "111111.1111")
    expect(customer2).to_not be_valid
  end
end
