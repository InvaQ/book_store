FactoryGirl.define do
  sequence :country_name { |n| "Country_name#{n}" }

  factory :country do
    name { generate(:country_name) }
  end
end
