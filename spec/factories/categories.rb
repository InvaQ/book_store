require 'ffaker'

FactoryGirl.define do
  sequence :category_name { |n| "Category_name#{n}" }

  factory :category do
    title { generate(:category_name) }

    transient do
      books_count 5
    end
    
    after(:create) do |category, evaluator|
      create_list :book, evaluator.books_count, category: category        
    end

  end
end