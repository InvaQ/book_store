class Country < ApplicationRecord
  has_many :deliveries
  
  validates :name, presence: true
end
