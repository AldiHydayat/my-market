class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.integer :order_id
      t.integer :product_id
      t.text :product_summary
      t.integer :quantity

      t.timestamps
    end
  end
end
