class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product
  serialize :product_summary

  before_create :set_product_summary

  validates :product_id, :quantity, presence: true

  scope :get_product_summary, ->(id) { pluck(:product_summary).find(id) }

  private

  def set_product_summary
    # HARUSNYA IMAGE JUGA MASUK YA, JGN RELASI LAGI NANTI PAS MANGGILNYA
    self.product_summary = self.product.slice(:id, :name, :price, :description)
  end
end
