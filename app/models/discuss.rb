class Discuss < ApplicationRecord
  belongs_to :product
  belongs_to :user
  has_many :replies, class_name: "Discuss", foreign_key: "discuss_id", dependent: :destroy
  belongs_to :reply, class_name: "Discuss", optional: true

  validates :product_id, :user_id, :comment, presence: true

  scope :get_discusses_product, ->(product_id) { where(product_id: product_id, discuss_id: nil).order(created_at: :desc) }
end
