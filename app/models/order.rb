class Order < ApplicationRecord

  belongs_to :user, optional: true
  has_one :coupon, dependent: :nullify
  belongs_to :delivery, optional: true
  belongs_to :credit_card, optional: true
  has_one :cart, dependent: :destroy
  

end
