class Product < ApplicationRecord
  has_many :carts, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_many :product_categories, dependent: :destroy
  has_many :product_photos, dependent: :destroy
  has_many :categories, through: :product_categories
  has_many :reviews, dependent: :destroy
  has_many :discusses, dependent: :destroy
  accepts_nested_attributes_for :product_categories, :product_photos, reject_if: :all_blank

  extend FriendlyId
  friendly_id :name, use: :slugged

  acts_as_votable

  validates :name, :price, :description, :stock, :sold, presence: true
  validates :price, :stock, :sold, numericality: true

  validates_presence_of :product_photos
  validates_presence_of :product_categories

  scope :active_products, -> { where(is_active: true) }

  def is_active_toggle
    if is_active
      self.is_active = false
    else
      self.is_active = true
    end

    save
  end

  def reduce_stock_and_increase_sold(quantity)
    self.stock = stock - quantity
    self.sold = sold + quantity
    save
  end

  def wishlist_toggle(user)
    if user.liked? self
      unliked_by user
    else
      liked_by user
    end
  end

  def calculate_avarage_rating
    sum = 0
    ratings_count = self.reviews_count
    if ratings_count > 0
      count_each_ratings = self.reviews.group(:rating).count
      count_each_ratings.each { |key, val| sum += key * val }
      avg = sum.to_f / ratings_count
      self.update!(rating: avg.truncate(1))
    else
      self.update!(rating: 0)
    end
  end
end
