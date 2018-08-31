FactoryBot.define do
  factory :comment do
    body "Great!"
    rating 5
    user
    product
  end
end
