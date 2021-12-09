class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :comment
      t.integer :product_id
      t.integer :user_id

      t.timestamps
    end
  end
end
