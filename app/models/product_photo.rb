class ProductPhoto < ApplicationRecord
  belongs_to :product

  validates :photo, presence: true
  mount_uploader :photo, PhotoUploader
end
