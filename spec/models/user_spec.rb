require 'rails_helper'

describe User do
  context "when a new user is created" do
    it "is valid with a correct email address and password >= 6 letters" do
      expect( FactoryBot.build(:user, password:"abcdef")).to be_valid
    end

    it "is not valid without an email address" do
      expect( FactoryBot.build(:user, email: nil) ).not_to be_valid
    end

    it "is not valid without an '@' in the email address" do
      expect( FactoryBot.build(:user, email: "asd") ).not_to be_valid
    end

    it "is not valid with a password shorter than 6 letters" do
      expect( FactoryBot.build(:user, password:"123") ).not_to be_valid
      expect( FactoryBot.build(:user, password:"spec") ).not_to be_valid
    end
  end
end
