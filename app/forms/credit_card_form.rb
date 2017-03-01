class CreditCardForm < Rectify::Form
  STR_ATTRS = [:number, :cvv, :expiry_month, :expiry_year].freeze

  STR_ATTRS.each do |str|
    attribute str, String
    validates str, presence: true
  end

  validates :cvv, :number, :expiry_month, :expiry_year, numericaly: { only_integer: true}
  validates :cvv, length: { in: 3..4}
  validates :number, length: 16
  validates :expiry_month, format: { with: /\A(0?[1-9]|1[012])\z/ }
  validates_each :expiry_year do |record, attr, value|
    record.errors.add(attr, 'expiry year must be not earlier than 6 months') if value <= Time.at(Time.now + (60*60*24*180)).year
  end, length: 4
  

end