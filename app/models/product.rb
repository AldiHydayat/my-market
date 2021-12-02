class Product < ApplicationRecord
  has_many :carts, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_many :product_categories, dependent: :destroy
  has_many :product_photos, dependent: :destroy
  has_many :categories, through: :product_categories
  accepts_nested_attributes_for :product_categories, :product_photos, reject_if: :all_blank

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, :price, :description, :stock, :sold, presence: true
  validates :price, :stock, :sold, numericality: true

  validates_associated :product_photos
  validates_associated :product_categories

  def is_active_toggle
    if is_active
      self.is_active = false
    else
      self.is_active = true
    end

    save
  end
end
