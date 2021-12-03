class ProductCategory < ApplicationRecord
  belongs_to :category
  belongs_to :product

  validates :category_id, presence: true
end
