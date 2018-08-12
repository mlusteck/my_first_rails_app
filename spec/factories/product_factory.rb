FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Beast #{n}" }
    description "legendary beast"
    colour "red"
  end
end
