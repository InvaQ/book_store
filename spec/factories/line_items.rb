require 'ffaker'

FactoryGirl.define do
  factory :line_item do
    quantity 1
    price 0.01

    after(:create) do |line_item|
      create(:book, line_items: [line_item])
    end
  end
end