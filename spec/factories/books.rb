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
    materials   { FFaker::Lorem.words.join ', ' }
    
    trait :with_authors do
      transient do
        number_of_authors :rand
      end
    end
    

    trait :with_orders do
      transient do
        amount_of_orders 1
      end

      after(:create) do |book, value|
        create_list :line_item, value.amount_of_orders, book: book
      end
    end
  end
  
end