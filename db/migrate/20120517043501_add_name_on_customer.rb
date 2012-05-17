class AddNameOnCustomer < ActiveRecord::Migration
  def up
    add_column :customers, :name, :string
  end

  def down
  end
end
