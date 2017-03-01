class Order < ApplicationRecord
  include AASM

  belongs_to :user, optional: true
  has_one :coupon, dependent: :nullify
  belongs_to :delivery, optional: true
  belongs_to :credit_card, optional: true
  has_one :cart, dependent: :destroy
  
  aasm do
    state :creating, initial: true
    state :in_progress
    state :in_transit
    state :delivering
    state :canceling

    event :checkout do
      transitions from: :creating, to: :in_progress
    end
    
    event :confirmed do
      transitions from: :in_progress, to: :in_transit
    end

    event :sent do 
      transitions from: :in_transit, to: :delivering
    end

    event :cenceled do
      transitions from: :in_progress, to: :canceling
    end

  end



end
