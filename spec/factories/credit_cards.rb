FactoryGirl.define do
  factory :credit_card do
    number          '1234567890123456' 
    cvv             '123'
    expiry_month  02 
    expiry_year  2022 
    name            { FFaker::Name.name }
    order

  end
end
