class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product
  has_one :review
  serialize :product_summary

  before_create :set_product_summary

  validates :product_id, :quantity, presence: true

  scope :get_product_summary, ->(id) { find(id).product_summary }
  scope :set_to_reviewed, ->(id) { find(id).update!(is_reviewed: true) }

  private

  def set_product_summary
    hash = {}
    if product.discount > 0
      hash.merge!(product.slice(:id, :name, :description, :slug, :discount))

      d = (product.discount / 100) * product.price
      discount_price = product.price - d

      hash["price"] = discount_price
    else
      hash.merge!(product.slice(:id, :name, :price, :description, :slug))
    end

    hash["photos"] = product.product_photos.map do |pp|
      pp.photo_url
    end
    self.product_summary = hash
  end
end
