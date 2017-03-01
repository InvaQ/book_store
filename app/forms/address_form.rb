class AddressForm < Rectify::Form

STR_ATTRS = [:addressable_type,:first_name, :last_name, :address, :city, :zip, :phone ].freeze


STR_ATTRS.each do |str|
  attribute str, String
  validates str, presence: true
end
  attribute :country_id, Integer
  validates :country_id, presence: true

validates :first_name, :last_name, :address, :city, length: { maximum: 50}
validates :address, length:{ maximum: 50}
validates :zip, length: { maximum: 10}
#validates :phone, format: { with: /\A\+\d{6,12}\z/ }


end