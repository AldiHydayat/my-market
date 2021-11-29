class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details
  enum status: [:wait_for_confirmation, :processing, :shipping, :order_successful]

  validates :user_id, :status, :total_price, presence: true
  validates :total_price, numericality: true
end
