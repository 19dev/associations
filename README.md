# A Guide to Active Record Associations

## 1. Why Associations?

Modeller,

    class Customer < ActiveRecord::Base
        attr_accessible :name
        has_many :orders, :dependent => :destroy
    end

    class Order < ActiveRecord::Base
        attr_accessible :order_date
        belongs_to :customer
    end

Test,

    Customer.create(:name => 'Kuruyemişçi Mahmut')
    Customer.first.orders.create(:order_date => Time.now)
    Customer.first.orders
    Customer.first.destroy

## 2. The Types of Associations

- belongs_to
- has_one
- has_many
- has_many :through
- has_one :through
- has_and_belongs_to_many

Modeller,

    class Physician < ActiveRecord::Base
      attr_accessible :name
      has_many :appointments
      has_many :patients, :through => :appointments
    end

    class Patient < ActiveRecord::Base
      attr_accessible :name
      has_many :appointments
      has_many :physicians, :through => :appointments
    end

    class Appointment < ActiveRecord::Base
      attr_accessible :appointment_date, :physician_id, :patient_id
      belongs_to :physician
      belongs_to :patient
    end

Test,

    Physician.create(:name => 'Dr.Aysın')
    Patient.create(:name => 'Hacer')
    Patient.first.appointments.create(:physician_id => Physician.first.id, :appointment_date => Time.now)
    Patient.first.appointments
    Patient.first.appointments.first.physician

## 2.9 Polymorphic Associations

Modeller,

  class Picture < ActiveRecord::Base
    attr_accessible :imageable_id, :imageable_type, :name
    belongs_to :imageable, :polymorphic => true
  end
  class Employee < ActiveRecord::Base
    attr_accessible :name
    has_many :pictures, :as => :imageable
  end
  class Product < ActiveRecord::Base
    attr_accessible :name
    has_many :pictures, :as => :imageable
  end

Test,

  Employee.create(:name => 'Mennan')
  Employee.first.pictures
  Employee.first.pictures.create(:name => 'men.jpg', :imageable_type => 'r')
  Employee.first.pictures.create(:name => 'nan.jpg', :imageable_type => 'r')
  Employee.first.pictures

  Product.first.pictures

