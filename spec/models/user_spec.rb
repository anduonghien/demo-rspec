require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid first_name, last_name, email" do
    user = FactoryGirl.build(:user)
    expect(user).to be_valid
  end

  # Defaul expect(user).to have(1).errors_on(:first_name) has been removed from Rspec 2.9
  # And now, Rspec 3.0, if you want use it, add gem rspec-collection_matchers to Gemfile
  it "is invalid without a first_name" do
    user = FactoryGirl.build(:user, first_name: nil)
    expect(user).to have(1).errors_on(:first_name)
  end

  it "is invalid without a last_name" do
    user = FactoryGirl.build(:user, last_name: nil)
    expect(user).to have(1).errors_on(:last_name)
  end

  it "is invalid without a email" do
    user = FactoryGirl.build(:user, email: nil)
    expect(user).to have(2).errors_on(:email)
  end
  
  it "is invalid email format" do
    user = FactoryGirl.build(:user, email: "abc")
    expect(user).to have(1).errors_on(:email)
  end

  it "is invalid without a duplicate email" do
    FactoryGirl.create(:user, email: "duonghienan.dha@gmail.com")
    user = FactoryGirl.build(:user, email: "duonghienan.dha@gmail.com")

    expect(user).to have(1).errors_on(:email)
  end
  
  it "return full_name as a string" do
    user = FactoryGirl.create(
      :user,
      first_name: "An",
      last_name: "Duong Hien"
    )
    expect(user.full_name).to eq 'An Duong Hien'
  end

  describe "User has_many Post" do
    before :each do
      @user = FactoryGirl.create(:user)
    end

    context "User not have post" do
      it "user not have post" do
        expect(@user.posts.count).to eq 0
      end
    end

    context "User have post" do
      before :each do
        @post1 = FactoryGirl.create(:post, user: @user)
      end
      it "user have 1 post" do
        expect(@user.posts.count).to eq 1
      end

      it "user have >1 posts" do
        @post2 = FactoryGirl.create(:post, title: Faker::Lorem.sentence, content: Faker::Lorem.paragraph, user: @user)
        expect(@user.posts.count).to be > 1
      end

      it "get first post eq with post1" do
        expect(@user.posts.first.title).to eq @post1.title
      end

      it "get last post eq with post3" do
        @post3 = FactoryGirl.create(:post, title: Faker::Lorem.sentence, content: Faker::Lorem.paragraph, user: @user)
        expect(@user.posts.last.title).to eq @post3.title
      end
    end
  end
end
