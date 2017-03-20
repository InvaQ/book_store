class Delivery < ApplicationRecord
  belongs_to :country
  has_many :orders


  validates :min_days, :max_days, :name, :price, presence: true
  validates :min_days, numericality: { greater_than: 0, less_than_or_equal_to: :max_days }
  validates :max_days, numericality: { greater_than: 0 }
  def transfer
    "from #{min_days} to #{max_days}"
  end

end
