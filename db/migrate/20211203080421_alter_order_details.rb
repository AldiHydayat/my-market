class AlterOrderDetails < ActiveRecord::Migration[6.1]
  def up
    change_column :order_details, :product_summary, :json
  end

  def down
    change_column :order_details, :product_summary, :text
  end
end
