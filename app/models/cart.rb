class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :user, :product, :quantity, presence: true

  scope :get_my_cart, ->(user) { where(user: user) }

  def add_quantity(quantity)
    self.quantity = self.quantity + quantity
  end

  def self.find_cart(current_user, product_id)
    find_by(user: current_user, product_id: product_id)
  end

  def self.destroy_my_cart(user)
    where(user: user).destroy_all
  end

  def self.insert_cart(params)
    cart = find_or_initialize_by(params)
    if cart.persisted?
      cart.add_quantity(params[:quantity].to_i)
    end
    cart.save
  end
end
