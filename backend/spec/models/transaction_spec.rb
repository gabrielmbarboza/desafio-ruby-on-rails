require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:transaction1) { create(:transaction) }

  it "Should be valid" do
    expect(transaction1).to be_valid
  end

  it "Should not be valid, amount is not present" do
    transaction2 = build(:transaction, amount: nil)
    expect(transaction2).to_not be_valid
  end

  it "Should not be valid, performed_at is not present" do
    transaction2 = build(:transaction, performed_at: nil)
    expect(transaction2).to_not be_valid
  end

  it "Should not be valid, store is not present" do
    transaction2 = build(:transaction, store: nil)
    expect(transaction2).to_not be_valid
  end

  it "Should not be valid, customer is not present" do
    transaction2 = build(:transaction, customer: nil)
    expect(transaction2).to_not be_valid
  end

  it "Should not be valid, type_transaction is not present" do
    transaction2 = build(:transaction, transaction_type: nil)
    expect(transaction2).to_not be_valid
  end
end
