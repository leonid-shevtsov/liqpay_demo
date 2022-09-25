# frozen_string_literal: true

# A Product is something that can be purchased through an Order
class Product < ApplicationRecord
  has_many :orders, dependent: :destroy
end
