class ProductPhoto < ApplicationRecord
  belongs_to :product

  validates :product_id, :photo, :is_primary, presence: true
end
