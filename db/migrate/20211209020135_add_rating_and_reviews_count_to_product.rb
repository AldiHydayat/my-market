class AddRatingAndReviewsCountToProduct < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :rating, :float, default: 0
    add_column :products, :reviews_count, :integer, default: 0
    Product.find_each do |product|
      Product.reset_counters(product.id, :reviews)
    end
  end
end
