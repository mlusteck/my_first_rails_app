class Order < ApplicationRecord
  belongs_to :product
  belongs_to :user

  def total_in_euro
    total_in_cents.to_d*0.01
  end
end
