require 'rails_helper'

describe Order do
  context "when a new order is created" do
    let(:product) { Product.create!(name: "speculum") }
    let(:user) { User.create!(email: "spec@example.com", password:"specspec") }

    it "is not valid without a product" do
      expect(Order.new(user: user)).not_to be_valid
    end

    it "is not valid without a user" do
      expect(Order.new(product: product)).not_to be_valid
    end
  end
end
