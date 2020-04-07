require 'rails_helper'

describe "Log in" do
  it "can log in as a default user" do
    user = User.create(name: "David", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 1)
    visit '/login'
    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on 'Login'

    expect(current_path).to eq('/profile')
  end

  it "can log in as a merchant user" do
    user = User.create(name: "David", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 2)
    visit '/login'
    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on 'Login'

    expect(current_path).to eq('/merchant/dashboard')
  end

  it "can log in as an admin user" do
    user = User.create(name: "David", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 3)
    visit '/login'
    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on 'Login'

    expect(current_path).to eq('/admin/dashboard')
  end


end
