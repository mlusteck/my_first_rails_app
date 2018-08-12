FactoryBot.define do
  sequence(:email) { |n| "user#{n}@example.com" }

  factory :user do
    email
    first_name "Otto"
    last_name  "Example"
    password   "1234567"
    
    factory :admin do
      admin true
    end
  end

end
