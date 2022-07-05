require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it "Should create a user" do 
      @user = User.new(
        first_name: "robert",
        last_name: "robert",
        email: "robert@robert.com",
        password: "ABCDEF",
        password_confirmation: "ABCDEF"
      )
      @user.valid?
      expect(@user.errors).to be_empty
    end
    
    it "throw error when first name empty" do 
      @user = User.new(
        first_name: nil,
        last_name: "robert",
        email: "robert@robert.com",
        password: "ABCDEF",
        password_confirmation: "ABCDEF"
      )

      @user.valid?
      expect(@user.errors).to include(:first_name)
    end

    it "throw error when last name empty" do 
      @user = User.new(
        first_name: "robert",
        last_name: nil,
        email: "robert@robert.com",
        password: "ABCDEF",
        password_confirmation: "ABCDEF"
      )

      @user.valid?
      expect(@user.errors).to include(:last_name)
    end

    it "throw error when email empty" do 
      @user = User.new(
        first_name: "robert",
        last_name: "robert",
        email: nil,
        password: "ABCDEF",
        password_confirmation: "ABCDEF"
      )

      @user.valid?
      expect(@user.errors).to include(:email)
    end

    it "throw error when email is not unique" do 
      @user1 = User.new(
        first_name: "robert",
        last_name: "robert",
        email: "robert@robert.com",
        password: "ABCDEF",
        password_confirmation: "ABCDEF"
      )
      @user1.save

      @user2 = User.new(
        first_name: "robert",
        last_name: "robert",
        email: "ROBERT@robert.com",
        password: "ABCDEF",
        password_confirmation: "ABCDEF"
      )
      @user2.save

      expect(@user2.errors).to include(:email)
    end

    it "Should not create a user if passwords do not match" do 
      @user = User.new(
        first_name: "robert",
        last_name: "robert",
        email: "robert@robert.com",
        password: "ABCDEFG",
        password_confirmation: "ABCDEFH"
      )

      @user.valid?
      expect(@user.errors).to include(:password_confirmation)
    end

    it "Should not create a user if no password" do 
      @user = User.new(
        first_name: "robert",
        last_name: "robert",
        email: "robert@robert.com"
      )

      @user.valid?
      expect(@user.errors).to include(:password)
    end

    it "Should not create a user if password is too short" do 
      @user = User.new(
        first_name: "robert",
        last_name: "robert",
        email: "robert@robert.com",
        password: "ABCDE",
        password_confirmation: "ABCDE"
      )

      @user.valid?
      expect(@user.errors).to include(:password)
    end
  end

  describe '.authenticate_with_credentials' do
    it "Should log a user in if credentials are correct" do 
      @user = User.new(
        first_name: "robert",
        last_name: "robert",
        email: "robert@robert.com",
        password: "ABCDEF",
        password_confirmation: "ABCDEF"
      )

      @user.save
      expect(User.authenticate_with_credentials("robert@robert.com", "ABCDEF")).to be_present
    end

    it "returns nil if user cannot be authenticated" do 
      @user = User.new(
        first_name: "robert",
        last_name: "robert",
        email: "robert@robert.com",
        password: "ABCDEF",
        password_confirmation: "ABCDEF"
      )

      @user.save
      expect(User.authenticate_with_credentials("robert@robert.com", "BCDEF")).to be_nil
    end

    it "returns nil if user cannot be authenticated" do 
      @user = User.new(
        first_name: "robert",
        last_name: "robert",
        email: "robert@robert.com",
        password: "ABCDEF",
        password_confirmation: "ABCDEF"
      )

      @user.save
      expect(User.authenticate_with_credentials(" ROBERT@robert.com", "ABCDEF")).to be_present.and have_attributes(:email => "robert@robert.com")
    end
  end
end