require 'rails_helper'

describe "admin's 'All Users' page" do
  before(:each) do
    @user_1 = User.create(name: "User 1", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 1)
    @user_2 = User.create(name: "User 2", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 1)
    @merchant_1 = User.create(name: "Merchant 1", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 2)
    @admin_1 = User.create(name: "Admin 1", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 3)
    @admin_2 = User.create(name: "Admin 2", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 3)
  end

  it "displays all users, their type, and date registered" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_1)

    visit "/"
    click_on("All Users")
    expect(current_path).to eq("/admin/users")

    expect(page).to have_link(@user_1.name)
    expect(page).to have_link(@user_2.name)
    expect(page).to have_link(@merchant_1.name)
    expect(page).to have_link(@admin_1.name)
    expect(page).to have_link(@admin_2.name)
    expect(page).to have_content("admin")
    expect(page).to have_content("merchant")
    expect(page).to have_content("basic")

    within(".users-list") do
      within("#user-#{@user_1.id}") do
        click_link(@user_1.name)
      end
    end

    expect(current_path).to eq("/admin/users/#{@user_1.id}")
    expect(page).to have_content(@user_1.name)
    expect(page).to have_content(@user_1.address)
    expect(page).to have_no_link("Update Information")
    expect(page).to have_no_link("Change Password")
  end
end
