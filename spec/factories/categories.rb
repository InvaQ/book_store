require 'ffaker'

FactoryGirl.define do
  sequence :category_name { |n| "Category_name#{n}" }

  factory :category do
    name { generate(:category_name) }

    transient do
      books_count 5
    end
    
    after(:create) do |category, evaluator|
      create_list(:book, evaluator.books_count, categories: [category])      
    end

  end
end