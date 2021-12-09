class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product, counter_cache: true

  validates :rating, presence: true

  after_destroy :reset_product_rating

  def review_product(product, user, order_detail_id)
    ActiveRecord::Base.transaction do
      self.product = product
      self.user = user
      self.save!
      self.product.calculate_avarage_rating
      OrderDetail.set_to_reviewed(order_detail_id)
    rescue
      false
    end
  end

  private

  def reset_product_rating
    self.product.calculate_avarage_rating
  end
end
