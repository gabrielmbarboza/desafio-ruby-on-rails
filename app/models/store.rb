# frozen_string_literal: true
# encoding: UTF-8

class Store < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :owner, presence: true

  before_validation do |store|
    store.slug = store&.name&.parameterize
  end
end
