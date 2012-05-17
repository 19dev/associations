class Physician < ActiveRecord::Base
  attr_accessible :name
  has_many :appointments
  has_many :patients, :through => :appointments
end
