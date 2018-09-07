require 'rails_helper'

describe Comment do
  context "when a new comment is created" do
    it "is  valid with a product, user, body and numeric rating" do
      expect(FactoryBot.build(:comment)).to be_valid
    end

    it "is not valid without a user" do
      expect(FactoryBot.build(:comment, user: nil)).not_to be_valid
    end

    it "is not valid without a product" do
      expect(FactoryBot.build(:comment, product: nil)).not_to be_valid
    end

    it "is not valid without a rating" do
      expect(FactoryBot.build(:comment, rating: nil)).not_to be_valid
    end

    it "is not valid without a numeric rating" do
      expect(FactoryBot.build(:comment, rating: "four")).not_to be_valid
    end
  end
end
