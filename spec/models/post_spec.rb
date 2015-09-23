require 'rails_helper'

RSpec.describe Post, type: :model do

  describe "Create post with user available" do
    before :each do
      @user = FactoryGirl.create(:user)
    end

    context "valid user and title" do
      it "is valid user and title" do
        # user = User.last
        # Create post
        post = @user.posts.new(
          title: Faker::Lorem.sentence,
          content: Faker::Lorem.paragraph 
        )

        expect(post).to be_valid
      end
    end

    context "valid user but invalid title" do
      it "is invalid without title" do
        # user = User.last

        post = @user.posts.new(title: nil)

        expect(post).to have(1).errors_on(:title)
      end
    end
  end

  it "is invalid without user" do
      post = Post.new(
        title: Faker::Lorem.sentence,
        content: Faker::Lorem.paragraph,
        user_id: nil
      )

      expect(post).to have(1).errors_on(:user)
  end

  it "is user create post not exits" do
    post = Post.new(
      title: Faker::Lorem.sentence,
      content: Faker::Lorem.paragraph,
      user_id: "10000a"
    )

    expect(post).to have(1).errors_on(:user)
  end
end
