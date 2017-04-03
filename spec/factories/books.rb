require 'ffaker'

FactoryGirl.define do

  factory :book do
    title { FFaker::Book.title }
    description { FFaker::Book.description }
    height 150
    width 100
    depth 47
    publication { rand(1990..2017) }
    price 10.99
    materials   { FFaker::Lorem.words.join ', ' }
    
    factory :book_with_authors do
      transient do
        authors_count 2
      end
      after(:create) do |book, evaluator|
        create_list(:author, evaluator.authors_count, books: [book])
      end
    end
    
    factory :book_with_line_items do
      transient do
        lines_count 1
      end
      after(:create) do |book, evaluator|
        create_list(:line_item, evaluator.lines_count, book: book)
      end
    end

  #   trait :with_orders do
  #     transient do
  #       amount_of_orders 1
  #     end

  #     after(:create) do |book, value|
  #       create_list :line_item, value.amount_of_orders, book: book
  #     end
  #   end
   end
  
end