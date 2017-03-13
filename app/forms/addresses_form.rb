class AddressesForm < Rectify::Form

  STR_ATTRS = [:first_name, :last_name,:address, :city, :zip, :phone ].freeze


  STR_ATTRS.each do |str|
    #binding.pry
    attribute str, String
    validates str, presence: true
  end

  attribute :country_id, Integer
  validates :country_id, presence: true

   validates :first_name, :last_name, :city, length: { maximum: 50}
   validates :address, length:{ maximum: 50}
   validates :zip, length: { maximum: 10}
  #validates :phone, format: { with: /\A\+\d{6,12}\z/ }

  def get_old_info(user)
    STR_ATTRS.each do |attribute|
      next if !user.respond_to?(attribute) || send(attribute).present?
      send("#{attribute}=", user.send(attribute))
    end
    self
  end

end