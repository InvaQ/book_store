require 'ffaker'

FactoryGirl.define do

  factory :category do
    name { ['Mobile Development', 'Photo', 'Web Design'].sample }
  end

  
end