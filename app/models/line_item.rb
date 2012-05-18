class LineItem < ActiveRecord::Base
  attr_accessible :name, :order_id
  belongs_to :order
end
