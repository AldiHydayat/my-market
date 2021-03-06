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

    event :ship, after: :send_deliver_order_email do
      transitions to: :shipping
    end

    event :succeed, after: :send_order_succeed_email do
      transitions to: :order_successful
    end
  end

  def create_order
    ActiveRecord::Base.transaction do
      self.save!
      self.order_details.each do |od|
        if od.product.stock == 0
          raise ActiveRecord::Rollback
        end
      end
      Cart.destroy_my_cart(self.user)
      admin = User.find_by(level: "admin").email
      OrderMailer.with(order: self, receiver: admin).new_order.deliver_later
    end
  end

  def set_total_price
    total_price = 0
    order_details.each do |order_detail|
      if order_detail.product.discount > 0
        discount = (order_detail.product.discount / 100) * order_detail.product.price
        discount_price = order_detail.product.price - discount

        total_price = total_price + (order_detail.quantity * discount_price)
      else
        total_price = total_price + (order_detail.quantity * order_detail.product.price)
      end
    end
    self.total_price = total_price
  end

  def send_deliver_order_email
    ActiveRecord::Base.transaction do
      self.save!
      admin = User.find_by(level: "admin").email
      OrderMailer.with(order: self, receiver: user.email).deliver_order.deliver_later
    end
  end

  def send_order_succeed_email
    ActiveRecord::Base.transaction do
      self.save!
      admin = User.find_by(level: "admin").email
      OrderMailer.with(order: self, receiver: admin).order_successful.deliver_later
    end
  end

  def confirm_order
    self.process
    order_details.each do |od|
      od.product.reduce_stock_and_increase_sold(od.quantity)
    end
    save

    OrderMailer.with(order: self, receiver: user.email).order_confirmed.deliver_later
  end
end
