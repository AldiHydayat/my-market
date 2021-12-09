class AddIdOrderDetailToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :order_detail_id, :integer
  end
end
