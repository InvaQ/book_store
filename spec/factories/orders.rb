FactoryGirl.define do


  factory :order do
    trait :with_items do
      transient do
        amount_of_items 5
      end

      after(:create) do |order, value|
        create_list :line_item, value.amount_of_items, order: order
      end
    end

    trait :with_addresses do
      after(:create) do |order|
        create(:billing_address, addressable: order)
        create(:shipping_address, addressable: order)
      end
    end

    trait :with_delivery do
      after(:create) do |order|
        order.delivery = create(:delivery)
        order.save
      end
    end

    trait :with_credit_card do
      after(:create) do |order|
        order.credit_card = create(:credit_card)
        order.save
      end
    end
    
  end
end
