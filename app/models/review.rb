class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product, counter_cache: true
  belongs_to :order_detail

  validates :rating, presence: true

  after_destroy :reset_product_rating

  def review_product(product, user)
    ActiveRecord::Base.transaction do
      self.product = product
      self.user = user
      self.save!
      self.product.calculate_avarage_rating
      OrderDetail.set_to_reviewed(self.order_detail_id)
    rescue
      false
    end
  end

  def edit_review_product(params)
    ActiveRecord::Base.transaction do
      self.update!(params)
      self.product.calculate_avarage_rating
    rescue
      false
    end
  end

  private

  def reset_product_rating
    self.product.calculate_avarage_rating
  end
end
