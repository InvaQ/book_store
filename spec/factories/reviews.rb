FactoryGirl.define do
  factory :review do
    title 'string'
    description 'text'
    rate 3
    

    trait :with_verified_user do
      after(:create) do |review|
        
        review.user_id = create(:user, :for_verified_review) 
        review.save
      end
    end

  end
end