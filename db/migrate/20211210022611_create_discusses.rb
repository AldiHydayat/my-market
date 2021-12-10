class CreateDiscusses < ActiveRecord::Migration[6.1]
  def change
    create_table :discusses do |t|
      t.integer :product_id
      t.integer :user_id
      t.text :comment
      t.integer :discuss_id

      t.timestamps
    end
  end
end
