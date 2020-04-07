require 'rails_helper'

RSpec.describe "Log out" do

  before(:each) do
    @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 25)
    @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
  end

  it "When I visit loggout I am redirected to home page and am a visitor" do
    user = User.create(name: "David", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 1)
    visit '/login'

    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_on 'Login'

    visit "/items/#{@paper.id}"
    click_on "Add To Cart"
    within 'nav' do
      expect(page).to have_content("Cart: 1")
    end

    click_on 'Logout'

    expect(current_path).to eq('/')
    expect(page).to have_content("You're logged out")

    within 'nav' do
      expect(page).to have_content("Cart: 0")
    end
  end
end
