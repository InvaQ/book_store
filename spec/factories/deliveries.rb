FactoryGirl.define do
  sequence :delivery_title { |n| "Delivery#{n}" }

  factory :delivery do
    name { generate :delivery_title }
    min_days 3
    max_days 9
    price    { FFaker.numerify('#.##') } 
  end
end
