class TransactionType < ApplicationRecord
  validates :name, presence: true
  validates :operation, presence: true, format: { with: /\A[a-zA-Z]+\z/,
    message: "only allows letters" }, length: { is: 1 }
end
