class Product < ActiveRecord::Base

  before_destroy :remove_associated_reviews

  monetize :price_cents, numericality: true
  mount_uploader :image, ProductImageUploader

  belongs_to :category
  has_many :reviews

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :category, presence: true

  private

  def remove_associated_reviews
    self.reviews.each { |review| review.destroy }
  end

end
