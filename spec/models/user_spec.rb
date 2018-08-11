require 'rails_helper'

describe User do
  context "when a new user is created" do
    it "is valid with a correct email address and password >= 6 letters" do
      expect( User.new(email: "what@ever.com", password:"abcdef")).to be_valid
    end

    it "is not valid without an email address" do
      expect( User.new(first_name: "John")).not_to be_valid
    end

    it "is not valid without an '@' in the email address" do
      expect( User.new(email: "asd", password:"1234567")).not_to be_valid
    end

    it "is not valid with a password shorter than 6 letters" do
      expect( User.new(email: "test@example.com", password:"123")).not_to be_valid
      expect( User.new(email: "test@example.com", password:"spec")).not_to be_valid
    end
  end
end
