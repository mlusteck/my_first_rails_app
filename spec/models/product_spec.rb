require 'rails_helper'

describe Product do
  context "when the product has comments" do
    let(:product) { Product.create!(name: "speculum") }
    let(:user) { User.create!(email: "spec@example.com", password:"specspec") }
    before do
      product.comments.create!(rating: 1, user: user, body: "Awful beast!")
      product.comments.create!(rating: 3, user: user, body: "Average...")
      product.comments.create!(rating: 5, user: user, body: "Great!")
    end

    it "returns the average rating of all comments" do
      expect(product.average_rating).to eq 3
    end

    it "is not valid without a name" do
      expect( Product.new(description: "A horrible beast")).not_to be_valid
    end
  end
end
