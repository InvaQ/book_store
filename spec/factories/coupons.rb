FactoryGirl.define do

  factory :coupon do
    code '123'
    discount { 10 }
  end
end
