class Order < ActiveRecord::Base
  attr_accessible :order_date
  belongs_to :customer, :inverse_of => :orders
end
