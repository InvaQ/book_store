class Order < ApplicationRecord
  include AASM

  belongs_to :user, optional: true
  belongs_to :delivery, optional: true
  has_one :credit_card, dependent: :destroy
  has_many :line_items, dependent: :destroy
  #has_one :cart, dependent: :destroy
  has_one :shipping_address, -> { where addressable_type: "shipping_address"},
     class_name: Address, foreign_key: :addressable_id, foreign_type: :addressable_type, dependent: :destroy
  has_one :billing_address, -> { where addressable_type: "billing_address"},
     class_name: Address, foreign_key: :addressable_id, foreign_type: :addressable_type, dependent: :destroy

  
  aasm column: :state, whiny_transitions: false do
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

    event :canceled do
      transitions from: :in_progress, to: :canceling
    end

  end

  def add_line_items_from_cart(cart)
    
    cart.line_items.each do |item|
      binding.pry
      item.cart_id = nil
      line_items << item
    end
  end



end
