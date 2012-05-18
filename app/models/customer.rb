class Customer < ActiveRecord::Base
  attr_accessible :name
  has_many :orders, :dependent => :destroy, :inverse_of => :customer
end
