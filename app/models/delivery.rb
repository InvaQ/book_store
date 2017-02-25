class Delivery < ApplicationRecord
  belongs_to :country
  has_many :orders


  validates :min_days, :max_days, :name, :price, presence: true
  validates :min_days, :max_days, numericality: { greater_than: 0 }

end
