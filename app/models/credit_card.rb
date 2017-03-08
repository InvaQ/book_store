class CreditCard < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :order
end
