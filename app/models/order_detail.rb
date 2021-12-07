class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product
  serialize :product_summary

  before_create :set_product_summary

  validates :product_id, :quantity, presence: true

  scope :get_product_summary, ->(id) { pluck(:product_summary).find(id) }

  private

  def set_product_summary
    hash = {}
    hash.merge!(product.slice(:id, :name, :price, :description))
    hash["photos"] = product.product_photos.map do |pp|
      pp.photo_url
    end
    self.product_summary = hash
  end
end
