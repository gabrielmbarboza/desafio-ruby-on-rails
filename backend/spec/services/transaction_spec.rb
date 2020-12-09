# encoding: UTF-8

require 'rails_helper'

RSpec.describe TransactionService, type: :model do
  before :all do
    (1..10).each do |code|
      TransactionType.create(label: Faker::Types.rb_string, operation: %w[C D].sample, code: code)
    end
  end

  let(:cnab) { "MzIwMTkwMzAxMDAwMDAxNDIwMDA5NjIwNjc2MDE3NDc1MyoqKiozMTUzMTUzNDUzSk/Dg08gTUFDRURPICAgQkFSIERPIEpPw4NP" } 
  let(:transactions) { TransactionService.new(cnab).call }

  it "Should be have one transaction" do
    transactions.length.should eq(1)
  end

  it "Should be have a transaction" do
    transactions.first.transaction_type.code.should eq(3)
    transactions.first.amount.to_f.should eq(142.0)
    transactions.first.customer.itr.should eq("09620676017")
    transactions.first.creditcard.should eq("4753****3153")
    transactions.first.store.name.force_encoding("UTF-8").should eq("BAR DO JOÃO")
    transactions.first.store.owner.force_encoding("UTF-8").should eq("JOÃO MACEDO")
  end

  it "Should not be valid" do
    expect{ransactionService.new("").call}.to raise_error(StandardError)
  end
end