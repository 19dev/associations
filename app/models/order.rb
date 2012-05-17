class Order < ActiveRecord::Base
  belongs_to :customer
  attr_accessible :order_date
end
