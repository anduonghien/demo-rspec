require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid first_name, last_name, email" do
    user = User.new(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email
    )
    expect(user).to be_valid
  end

  # Defaul expect(user).to have(1).errors_on(:first_name) has been removed from Rspec 2.9
  # And now, Rspec 3.0, if you want use it, add gem rspec-collection_matchers to Gemfile
  it "is invalid without a first_name" do
    user = User.new(first_name: nil)
    expect(user).to have(1).errors_on(:first_name)
  end

  it "is invalid without a last_name" do
    user = User.new(last_name: nil)
    expect(user).to have(1).errors_on(:last_name)
  end

  it "is invalid without a email" do
    user = User.new(email: nil)
    expect(user).to have(2).errors_on(:email)
  end
  
  it "is invalid email format" do
    user = User.new(email: "abc")
    expect(user).to have(1).errors_on(:email)
  end

  it "is invalid without a duplicate email" do
    User.create(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: "duonghienan.dha@gmail.com" 
    )

    user = User.new(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: "duonghienan.dha@gmail.com" 
    )

    expect(user).to have(1).errors_on(:email)
  end
  
  it "return full_name as a string" do
    user = User.new(
      first_name: 'An',
      last_name: 'Duong Hien',
      email: Faker::Internet.email 
    )

    expect(user.full_name).to eq 'An Duong Hien'
  end
end
