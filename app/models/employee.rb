class Employee < ActiveRecord::Base
  attr_accessible :name
  has_many :pictures, :as => :imageable
end
