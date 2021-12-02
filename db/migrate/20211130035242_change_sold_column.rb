class ChangeSoldColumn < ActiveRecord::Migration[6.1]
  def up
    change_column :products, :sold, :integer, default: 0
  end

  def down
    change_column :products, :sold, :integer, default: nil
  end
end
