require 'ffaker'

FactoryGirl.define do

  factory :book do
    title { FFaker::Book.title }
    description { FFaker::Book.description }
    height 150
    width 100
    depth 47
    publication { rand(1990..2017) }
    price { rand(10..30) }
    
    association :categories, factory: :category
  end

  
end