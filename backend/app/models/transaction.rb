# frozen_string_literal: true
# encoding: UTF-8

class Transaction < ApplicationRecord
  validates :amount, presence: true
  validates :performed_at, presence: true

  belongs_to :store
  belongs_to :customer
  belongs_to :transaction_type
end
