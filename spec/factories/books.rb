require 'ffaker'

FactoryGirl.define do

  factory :book do
    title { FFaker::Book.title }
    description { FFaker::Book.description }
    height 150
     byebug
    width 100
    depth 47
    publication { rand(1990..2017) }
    price { rand(10..30) }
    
     before(:create) do

         FactoryGirl.create(:cart)
     end
    #association :categories, factory: :category
  end
  factory :item do
    
    before(:create) do
      FactoryGirl.create(:book)
      FactoryGirl.create(:cart)
    end

  end

  
end