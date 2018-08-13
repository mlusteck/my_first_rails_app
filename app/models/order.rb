class Order < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :user, presence: true
  validates :product, presence: true

  def total
    total_in_cents.to_d*0.01
  end
end
