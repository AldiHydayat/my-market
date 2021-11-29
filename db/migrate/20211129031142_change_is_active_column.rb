class ChangeIsActiveColumn < ActiveRecord::Migration[6.1]
  def up
    change_column :products, :is_active, :boolean, :default => true
  end

  def down
    change_column :products, :is_active, :boolean, :default => false
  end
end
