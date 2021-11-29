class CreateProductPhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :product_photos do |t|
      t.integer :product_id
      t.string :photo
      t.boolean :is_primary

      t.timestamps
    end
  end
end
