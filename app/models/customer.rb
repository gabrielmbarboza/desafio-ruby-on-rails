# frozen_string_literal: true

class Customer < ApplicationRecord
  validates :itr, presence: true, numericality: { only_integer: true },
                  length: { is: 11 }
end
