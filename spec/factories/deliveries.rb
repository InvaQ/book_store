FactoryGirl.define do
  factory :delivery do
    name 'Post'
    min_days 3
    max_days 9
    price    20.00
    
    before(:create) do |delivery|
      delivery.country = create(:country)
      delivery.save
    end
  end
end
