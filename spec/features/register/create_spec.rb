require 'rails_helper'

describe "registration" do
  it "creates a new user" do

    visit "/register"

    fill_in :name, with: "David"
    fill_in :address, with: "123 Test St"
    fill_in :city, with: "Denver"
    fill_in :state, with: "CO"
    fill_in :zip, with: "80204"
    fill_in :email, with: "123@example.com"
    fill_in :password, with: "password"
    fill_in :confirm_pass, with: "password"

    click_on "Submit"

    expect(current_path).to eq("/profile")
    expect(page).to have_content("Your account has been created.")
  end

  it "can't create a user without all fields" do
    visit "/register"

    fill_in :name, with: "David"
    fill_in :address, with: "123 Test St"
    fill_in :city, with: "Denver"
    fill_in :state, with: ""
    fill_in :zip, with: ""
    fill_in :password, with: "password"
    fill_in :confirm_pass, with: "password"

    click_on "Submit"

    expect(page).to have_content("Unable to create account: Required information missing.")

  end

  it "can't create a new user if user with email already exists" do
    User.create(name: "David", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password")

    visit "/register"

    fill_in :name, with: "David"
    fill_in :address, with: "123 Test St"
    fill_in :city, with: "Denver"
    fill_in :state, with: "CO"
    fill_in :zip, with: "80204"
    fill_in :email, with: "123@example.com"
    fill_in :password, with: "password"
    fill_in :confirm_pass, with: "password"

    click_on "Submit"

    expect(page).to have_content("Email already in use. Try a different email.")
    expect(find_field('Name').value).to eql "David"
    expect(find_field('Address').value).to eql "123 Test St"
    expect(find_field('City').value).to eql "Denver"
    expect(find_field('State').value).to eql "CO"
    expect(find_field('Zip').value).to eql "80204"

  end
end
