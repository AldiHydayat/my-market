class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_create :convert_address_to_html
  before_create :titleize_name
  before_update :convert_address_to_html
  before_update :titleize_name

  acts_as_voter

  has_many :carts
  has_many :orders
  enum level: [:admin, :buyer], _default: "buyer"

  validates :name, :phone_number, :address, :level, presence: true
  validates :phone_number, numericality: true

  def get_my_wishlist
    find_liked_items.select
  end

  private

  def convert_address_to_html
    self.address = address.gsub(/\n/, "<br>")
  end

  def titleize_name
    self.name = name.titleize
  end
end
