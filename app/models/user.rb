class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :carts
  has_many :orders
  enum status: [:admin, :buyer]

  validates :name, :phone_number, :address, :level, presence: true
  validates :phone_number, numericality: true
end
