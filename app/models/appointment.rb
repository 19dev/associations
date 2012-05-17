class Appointment < ActiveRecord::Base
  attr_accessible :appointment_date, :physician_id, :patient_id
  belongs_to :physician
  belongs_to :patient
end
