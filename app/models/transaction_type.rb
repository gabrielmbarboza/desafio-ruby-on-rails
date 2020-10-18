# frozen_string_literal: true
# encoding: UTF-8

class TransactionType < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true, 
    numericality: { only_integer: true }
  validates :operation, presence: true, format: { with: /\A[a-zA-Z]+\z/,
    message: "only allows letters" }, length: { is: 1 }

    before_validation do |transaction_type|
      transaction_type.slug = transaction_type&.name&.parameterize
    end
end
