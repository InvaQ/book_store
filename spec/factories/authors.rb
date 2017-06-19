#require 'ffaker'

FactoryGirl.define do
  sequence :first_name { |n| "author_first#{n}" }
  sequence :last_name { |n| "author_second#{n}" }

  factory :author do 
    first_name { generate(:first_name) }
    last_name { generate(:last_name) }
    
  end
end