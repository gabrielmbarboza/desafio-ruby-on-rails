require 'rails_helper'

RSpec.describe TransactionType, type: :model do
  let(:transaction_type1) { create(:transaction_type) }

  it "Should be valid" do
    expect(transaction_type1).to be_valid
  end
  
  it "Should not be valid, name is not present" do
    transaction_type2 = build(:transaction_type, name: nil)
    expect(transaction_type2).to_not be_valid
  end

  it "Should not be valid, operation is not present" do
    transaction_type2 = build(:transaction_type, operation: nil)
    expect(transaction_type2).to_not be_valid
  end

  it "Should not be valid, operation is too long" do
    customer2 = build(:transaction_type, operation: 'foo')
    expect(customer2).to_not be_valid
  end

  it "Should not be valid, operation with invalid format" do
    customer2 = build(:transaction_type, operation: "1")
    expect(customer2).to_not be_valid
  end
end
