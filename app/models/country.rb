class Country < ApplicationRecord
  has_many :deliveries
  
  validates :name, :code, presence: true
end
