class Order < ActiveRecord::Base
  belongs_to :product

  validates_presence_of :product_id

  before_create :set_status_to_new

  def set_status_to_new
    self.status = 'new'
  end
end
