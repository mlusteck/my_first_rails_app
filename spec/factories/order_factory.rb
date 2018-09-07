FactoryBot.define do
  factory :order do
    total_in_cents 1234
    user
    product
  end
end
