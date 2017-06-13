require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) do
    @params = { first_name: "A", last_name: "B", email: "a@b.COM", password: "test123", password_confirmation: "test123" }
  end

  describe 'Validations' do
    it "should save given valid parameters" do
      @user = User.new(@params)
      expect(@user.valid?).to be true
      @user.save
      expect(@user.errors.full_messages).to be_empty
    end

    it "should not save given duplicate email parameter" do
      @user1 = User.new(@params)
      @user1.save
      @user2 = User.new(@params)
      @user2.save
      expect(@user2.errors.full_messages).to include "Email has already been taken"
    end

    it "should not save given duplicate email parameter with different case (upper <-> lower)" do
      @user1 = User.new(@params)
      @user1.save
      @params[:email] = "A@B.com"
      @user2 = User.new(@params)
      @user2.save
      expect(@user2.errors.full_messages).to include "Email has already been taken"
    end

    it "should not save given missing email parameter" do
      @params[:email] = nil
      @user = User.new(@params)
      @user.save
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end

    it "should not save given missing first_name parameter" do
      @params[:first_name] = nil
      @user = User.new(@params)
      @user.save
      expect(@user.errors.full_messages).to include "First name can't be blank"
    end

    it "should not save given missing last_name parameter" do
      @params[:last_name] = nil
      @user = User.new(@params)
      @user.save
      expect(@user.errors.full_messages).to include "Last name can't be blank"
    end

    it "should not save given missing password parameter" do
      @params[:password] = nil
      @user = User.new(@params)
      @user.save
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end

    it "should not save given missing password_confirmation parameter" do
      @params[:password_confirmation] = nil
      @user = User.new(@params)
      @user.save
      expect(@user.errors.full_messages).to include "Password confirmation can't be blank"
    end

    it "should not save given different password and confirmation parameters" do
      @params[:password_confirmation] = "different"
      @user = User.new(@params)
      @user.save
      expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end

    it "should not save given a password and confirmation shorter than 6 characters" do
      @params[:password] = "t"
      @params[:password_confirmation] = "t"
      @user = User.new(@params)
      @user.save
      expect(@user.errors.full_messages).to include "Password is too short (minimum is 6 characters)"
    end
  end

  describe 'authenticate_with_credentials' do

    it "should return correct user when matching email and password provided" do
      @user = User.new(@params)
      @user.save
      expect(User.authenticate_with_credentials(@params[:email], @params[:password])).to eq(@user)
    end

    it "should return correct user when matching email (with different case) and password provided" do
      @user = User.new(@params)
      @user.save
      expect(User.authenticate_with_credentials('A@B.com', @params[:password])).to eq(@user)
    end

    it "should return nil when matching email and wrong password provided" do
      @user = User.new(@params)
      @user.save
      expect(User.authenticate_with_credentials(@params[:email], 'wrong')).to be_nil
    end

    it "should return nil when non-existant email and any password provided" do
      @user = User.new(@params)
      @user.save
      expect(User.authenticate_with_credentials('random_but_incorrect_email', @params[:password])).to be_nil
    end

  end
end
