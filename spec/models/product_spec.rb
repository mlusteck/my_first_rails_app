require 'rails_helper'

describe Product do

  context "when a new product is created" do
    it "is not valid without a name" do
      expect( FactoryBot.build(:product, name: nil)).not_to be_valid
    end
  end

  context "when there are some similar products" do
    before do
      FactoryBot.create(:product, name:"BLA")
      FactoryBot.create(:product, name:"BLE")
      FactoryBot.create(:product, name:"BLI")
      @product = FactoryBot.create(:product, name:"BLO")
      FactoryBot.create(:product, name:"BLU")
    end

    it "searches correctly and case insensitive" do
      expect(Product.search("lo").to_a).to eq [@product]
    end
  end

  context "when the product has comments" do
    before do
      @product = FactoryBot.create(:product)
      @user = FactoryBot.create(:user)
      @product.comments.create!(rating: 1, user: @user, body: "Awful beast!")
      @product.comments.create!(rating: 3, user: @user, body: "Average...")
      @product.comments.create!(rating: 5, user: @user, body: "Great!")
    end

    it "returns the average rating of all comments" do
      expect(@product.average_rating).to eq 3
    end

    it "returns the comment with lowest rating" do
      expect(@product.lowest_rating_comment.rating).to eq 1
    end

    it "returns the comment with highest rating" do
      expect(@product.highest_rating_comment.rating).to eq 5
    end
  end
end
