class Customer < ActiveRecord::Base
  has_many :orders, :dependent => :destroy
  attr_accessible :name
end
