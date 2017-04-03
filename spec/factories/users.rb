require 'ffaker'


FactoryGirl.define do
  factory :user do
    
    email {FFaker::Internet.email}
    password 'Testtest00'
    password_confirmation 'Testtest00'
    #confirmed_at Date.today

    factory :admin do
      admin true
    end

    factory :user_with_addresses do
      after(:create) do |user|
        create(:billing_address, addressable: user)
        create(:shipping_address, addressable: user)
      end
    end

    trait :for_verified_review do
      transient do
        amount_of_orders 1
      end
      after(:create) do |user, evaluator|
        create_list(:order_with_item_verified, evaluator.amount_of_orders, user: user, state: 'delivered')
      end
    end
    
  end
end
