require 'rails_helper'

RSpec.describe Store, type: :model do
  let(:store1) { create(:store) }

  it "Should be valid" do
    expect(store1).to be_valid
  end

  it "Should not be valid, name is not present" do
    store2 = build(:store, name: nil)
    expect(store2).to_not be_valid
  end

  it "Should not be valid, city is not present" do
    store2 = build(:store, owner: nil)
    expect(store2).to_not be_valid
  end
end
