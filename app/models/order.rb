class Order < ApplicationRecord
  include AASM

  belongs_to :user
  has_many :order_details, dependent: :destroy
  enum status: [:wait_for_confirmation, :processing, :shipping, :order_successful]

  validates :user_id, :total_price, presence: true
  validates :total_price, numericality: true

  accepts_nested_attributes_for :order_details

  validates_associated :order_details

  scope :get_my_order, ->(user) { where(user: user) }

  aasm column: :status do
    state :wait_for_confirmation, initial: true
    state :processing
    state :shipping
    state :order_successful

    event :process do
      transitions to: :processing
    end

    event :ship do
      transitions to: :shipping
    end

    event :succeed do
      transitions to: :order_successful
    end
  end

  def set_total_price
    total_price = 0
    order_details.each do |order_detail|
      total_price = total_price + (order_detail.quantity * order_detail.product.price)
    end
    self.total_price = total_price
  end

  def confirm_order
    self.process
    order_details.each do |od|
      od.product.reduce_stock_and_increase_sold(od.quantity)
    end
    save
  end
end
