# frozen_string_literal: true
# encoding: UTF-8

class TransactionType < ApplicationRecord
  validates :label, presence: true
  validates :code, presence: true, numericality: { only_integer: true }
  validates :operation, presence: true, format: { with: /\A[a-zA-Z]+\z/,
    message: "only allows letters" }, length: { is: 1 }
end
