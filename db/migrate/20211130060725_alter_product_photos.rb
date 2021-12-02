class AlterProductPhotos < ActiveRecord::Migration[6.1]
  def up
    rename_column :product_photos, :is_primary, :is_main_photo
    change_column :product_photos, :is_main_photo, :boolean, default: false
  end

  def down
    change_column :product_photos, :is_main_photo, :boolean, default: nil
    rename_column :product_photos, :is_main_photo, :is_primary
  end
end
