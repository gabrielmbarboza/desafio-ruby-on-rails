# frozen_string_literal: true
# encoding: UTF-8

class Store < ApplicationRecord
  validates :name, presence: true
  validates :owner, presence: true
end
