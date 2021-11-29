class Product < ApplicationRecord
  has_many :carts
  has_many :order_details
  has_many :product_categories
  has_many :product_photos
  has_many :categories, through: :product_categories

  validates :name, :price, :description, :stock, :sold, :is_active, presence: true
  validates :price, :stock, :sold, numericality: true
end
