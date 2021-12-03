class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product
  serialize :product_summary

  validates :product_id, :product_summary, :quantity, presence: true
end
