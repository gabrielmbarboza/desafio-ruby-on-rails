class Transaction < ApplicationRecord
  validates :amount, presence: true
  validates :t_date, presence: true
  validates :t_time, presence: true

  belongs_to :store
  belongs_to :customer
  belongs_to :transaction_type
end
