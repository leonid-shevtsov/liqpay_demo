# frozen_string_literal: true

# An Order is an instance of a payment in our database
class Order < ApplicationRecord
  belongs_to :product

  serialize :data

  scope :latest, -> { order(created_at: :desc).limit(100) }

  before_create :set_status_to_new

  def set_status_to_new
    self.status = 'new'
  end
end
