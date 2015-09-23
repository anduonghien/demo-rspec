require 'rails_helper'

RSpec.describe Post, type: :model do
  it "is valid user and title" do
    # Create user
    user = FactoryGirl.create(:user)
    # Create post
    post = user.posts.new(
      title: Faker::Lorem.sentence,
      content: Faker::Lorem.paragraph 
    )

    expect(post).to be_valid
  end

  it "is invalid without title" do
    user = FactoryGirl.create(:user)

    post = user.posts.new(title: nil)

    expect(post).to have(1).errors_on(:title)
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
