class Review < ActiveRecord::Base

  belongs_to :user
  belongs_to :product

  validates_associated :user
  validates :user, presence: true
  validates_associated :product
  validates :product, presence: true
  validates :rating, presence: true
  validates :rating, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
end
