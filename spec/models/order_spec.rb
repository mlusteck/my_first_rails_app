require 'rails_helper'

describe Order do
  context "when a new order is created" do
    it "is valid with a user and product" do
      expect(FactoryBot.build(:order)).to be_valid
    end
    
    it "is not valid without a product" do
      expect(FactoryBot.build(:order, product:nil)).not_to be_valid
    end

    it "is not valid without a user" do
      expect(FactoryBot.build(:order, user:nil)).not_to be_valid
    end
  end
end
