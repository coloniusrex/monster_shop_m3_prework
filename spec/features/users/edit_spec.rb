require 'rails_helper'

describe "all users" do
  it "can edit their information" do

    user = User.create(name: "David", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/profile"

    within ".user-info" do
      expect(page).to have_content("David")
      click_link("Update Information")
    end

    expect(current_path).to eq("/profile/edit")

    expect(find_field('Name').value).to eql "David"
    expect(find_field('Address').value).to eql "123 Test St"
    expect(find_field('Email').value).to eql "123@example.com"

    fill_in :name, with: "Bobby"
    fill_in :address, with: "456 Test Ave"
    fill_in :city, with: "Castle Rock"
    fill_in :state, with: "CO"
    fill_in :zip, with: "80104"
    fill_in :email, with: "222@example.com"

    click_on("Save Information")

    expect(current_path).to eq("/profile")

    within ".user-info" do
      expect(page).to have_content("Bobby")
      expect(page).to have_content("456 Test Ave")
    end
  end

  it "can't update email if email already exists" do
    user_1 = User.create(name: "Bobby", address: "456 Test Ave", city: "Castle Rock", state: "CO", zip: "80104", email: "123@example.com", password: "password", role: 1)
    user_2 = User.create(name: "David", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "email@example.com", password: "password", role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit "/profile"

    within ".user-info" do
      expect(page).to have_content("Bobby")
      click_link("Update Information")
    end

    fill_in :email, with: "email@example.com"
    click_on "Save Information"

    expect(page).to have_content("That email is already in use.")
  end
end
