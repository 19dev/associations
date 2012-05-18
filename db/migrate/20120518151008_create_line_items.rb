class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.string :name
      t.integer :order_id

      t.timestamps
    end
  end
end
