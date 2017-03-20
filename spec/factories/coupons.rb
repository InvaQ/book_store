FactoryGirl.define do
  sequence :coupon_code { |n| "123#{n}" }

  factory :coupon do
    code { generate :coupon_code }
    discount { rand(100) }
  end
end
