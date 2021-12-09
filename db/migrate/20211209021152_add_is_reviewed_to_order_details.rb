class AddIsReviewedToOrderDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :order_details, :is_reviewed, :boolean, default: false
  end
end
