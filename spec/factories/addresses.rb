FactoryGirl.define do
  factory :address, class: 'Address' do
    first_name { FFaker::Name.first_name }
    last_name  { FFaker::Name.last_name }
    city       { FFaker::AddressUS.city }
    address     { FFaker::AddressUS.street_address }
    zip        { FFaker::AddressUS.zip_code.to_i }
    phone      { FFaker.numerify('+12345678') }

    factory :billing_address, class: 'BillingAddress'
    factory :shipping_address, class: 'ShippingAddress'
  end
end