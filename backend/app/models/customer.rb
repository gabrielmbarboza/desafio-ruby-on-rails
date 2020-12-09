# frozen_string_literal: true
# encoding: UTF-8

class Customer < ApplicationRecord
  validates :itr, presence: true, numericality: { only_integer: true },
                  length: { is: 11 }
end
