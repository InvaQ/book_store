require 'ffaker'


FactoryGirl.define do
  factory :user do
    
    email {FFaker::Internet.email}
    password 'Testtest00'
    password_confirmation 'Testtest00'
     confirmed_at Date.today

    factory :admin do
      is_admin true
    end

    trait :with_addresses do
      after(:create) do |user|
        create(:billing_address, addressable: user)
        create(:shipping_address, addressable: user)
      end
    end
    
  end
end
