class CreditCardForm < Rectify::Form
  STR_ATTRS = [:number, :name].freeze
  INT_ATTRS = [:cvv, :expiry_month, :expiry_year].freeze

  STR_ATTRS.each do |str|
    attribute str, String
    validates str, presence: true
  end
    INT_ATTRS.each do |int|
    attribute int, Integer
    validates int, presence: true
  end

  validates :cvv, :number, :expiry_month, :expiry_year, numericality: { only_integer: true}
  validates :cvv, length: { in: 3..4}
  validates :number, length: { is: 16 }
  validates :expiry_month, format: { with: /\A(0?[1-9]|1[012])\z/ }
  validates :expiry_year,  length: { is: 4}
  validates_each :expiry_year do |record, attr, value|

    record.errors.add attr, 'expiry year must not be earlier than 6 months from today' if value.to_i < (Time.now + 6.month).year
  end

  private

  

end