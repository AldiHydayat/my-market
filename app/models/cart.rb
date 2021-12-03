class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :user, :product, :quantity, presence: true

  scope :get_my_cart, ->(user) { where(user: user) }

  def add_quantity(quantity)
    self.quantity = self.quantity + quantity
    save
  end

  def self.find_cart(current_user, product_id)
    find_by(user: current_user, product_id: product_id)
  end

  def self.destroy_my_cart(user)
    where(user: user).destroy_all
  end
end
