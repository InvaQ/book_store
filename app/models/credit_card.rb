class CreditCard < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :order
  has_one :address, as: :addressable
end
