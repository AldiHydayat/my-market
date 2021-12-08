class AddDiscountToProduct < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :discount, :float, default: 0
  end
end
