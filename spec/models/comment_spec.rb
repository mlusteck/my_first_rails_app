require 'rails_helper'

describe Comment do
  context "when a new comment is created" do
    let(:product) { Product.create!(name: "speculum") }
    let(:user) { User.create!(email: "spec@example.com", password:"specspec") }

    it "is  valid with a product, user, body and numeric rating" do
      expect( Comment.new( product: product, user: user, body: "Great!", rating: 5 ) ).to be_valid
    end

    it "is not valid without a user" do
      expect( Comment.new( product: product, body: "Great!", rating: 5 ) ).not_to be_valid
    end

    it "is not valid without a product" do
      expect( Comment.new( user: user, body: "Great!", rating: 5 ) ).not_to be_valid
    end

    it "is not valid without a rating" do
      expect( Comment.new( product: product, user: user, body: "Great!") ).not_to be_valid
    end

    it "is not valid without a numeric rating" do
      expect( Comment.new( product: product, user: user, body: "Nice!", rating: "four" ) ).not_to be_valid
    end
  end
end
