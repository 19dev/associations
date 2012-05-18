class Order < ActiveRecord::Base
  attr_accessible :order_date
  belongs_to :customer
  has_many :line_items
end
