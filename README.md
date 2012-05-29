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

![has many through](http://guides.rubyonrails.org/images/has_many_through.png)

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

Ayrıca,
![has one through](http://guides.rubyonrails.org/images/has_one_through.png)
![has and belongs to many](http://guides.rubyonrails.org/images/habtm.png)

`create_table :assemblies_parts, :id => false do |t|`

id:false model üretilmesini engelliyor.

## 2.9 Polymorphic Associations

![polymorphic](http://guides.rubyonrails.org/images/polymorphic.png)

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

## 3.5 Bi-directional Associations

![resim](http://guides.rubyonrails.org/images/has_many.png)

(ESKI) Modeller,

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
    Customer.last.orders.create(:order_date => Time.now)

    c = Customer.last
    o = c.orders.last
    c.name == o.customer.name # => true
    c.name = 'simitci'
    c.name == o.customer.name # => false

olan nedir? Verinin iki ayrı kopyası tutulmakta ve bir taraf diğerinden habersiz
durumdadır. Çözümü ise "bi-directional associations"

(YENİ) Modeller,

    class Customer < ActiveRecord::Base
        attr_accessible :name
        has_many :orders, :dependent => :destroy, :inverse_of => :customer
    end

    class Order < ActiveRecord::Base
        attr_accessible :order_date
        belongs_to :customer, :inverse_of => :orders
    end

Test,

    Customer.create(:name => 'Kuruyemişçi Mahmut')
    Customer.last.orders.create(:order_date => Time.now)

    c = Customer.last
    o = c.orders.last
    c.name == o.customer.name # => true
    c.name = 'simitci'
    c.name == o.customer.name # => true

kısıtlamaları vardır.

# 4 Detailed Association Reference

Bazı trikler,

    > c = Customer.create(:name => 'Simitci')
    > o = c.orders.create(:order_date => Time.now)

    > o.customer
    > c.orders

    > o.customer = Customer.create(:name => 'manav')
    > o.customer.name
    'manav'

    > o.build_customer(:name => 'market')   # new
    > o.create_customer(:name => 'market')  # create
    > o.customer.name
    'market'

#### 4.1.2.7 :include

Modeller,

    class LineItem < ActiveRecord::Base
      belongs_to :order
    end
    class Order < ActiveRecord::Base
      belongs_to :customer
      has_many :line_items
    end
    class Customer < ActiveRecord::Base
      has_many :orders
    end

Test,

    c = Customer.create(:name => 'yesil')
    o = c.orders.create(:order_date => Time.now)
    li = o.line_items.create(:name => 'foo')

    o.line_items
    li.order_id

eğer, `li` üzerinden `order` a ve onun üzerinden de `customer` a ulaşmak
istersen,

    class LineItem < ActiveRecord::Base
      belongs_to :order, :include => :customer
    end

demen yeterli. Bu durumda,

    li.order
    li.order.customer

iş görür.

### 4.1.3 Do Any Associated Objects Exist?

Test,

    if o.customer.nil?
      @msg = "No customer found for this order"
    end

## 4.3 hasmany Association Reference

Customer i belirtmeksizin, yeni bir Order oluşturmak/sonuna eklemek,

    > c.orders << Order.create(:order_date => Time.now)

Son Order i silmek istersek,

    > c.orders.delete(Order.last)

Order id lerini görmek istersen,

    > c.order_ids
    [14, 42]

Ekleme silme yapabilirsin,

    > c.order_ids = [14, 23]

böylelikle arkada 42 id li Order silinirken, var olan 23 nolu id bu müşterinin
Order u olur. Bu işlem öncesinde,

    > Order.find(23).customer.name
    'foo'

iken işlem sonrasında,

    > Order.find(23).customer.name
    'bar'

olacaktır ki `bar`, `c` değişkeninde tutulan müşterinin adıdır (`# c.name =>
'bar'`).

Ararken,

    > @orders = c.orders.where(["order_date < ? ", 2.minutes.ago])

böyle hazırlanır ya böyle

    > @orders[0]

ya da böyle,

    > @orders.first

şeklinde veritabanından sorgulanır.
