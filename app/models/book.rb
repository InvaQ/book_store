class Book < ApplicationRecord
  has_many :pictures, as: :imageable
  has_many :reviews
  has_many :categorizations
  has_many :categories, through: :categorizations
  has_and_belongs_to_many :authors

  validates :title, :description, presence: true
  validates :price, numericality: {greater_than_or_equel_to: 0.01}
  validates :title, uniqueness: true
  
end
