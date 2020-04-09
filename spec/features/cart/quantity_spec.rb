require 'rails_helper'

describe "cart page" do

  before(:each) do
    @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
    @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
  end

  it "has a link to +1/-1 quantity" do
    visit "/items/#{@paper.id}"
    click_on "Add To Cart"

    visit "/items/#{@pencil.id}"
    click_on "Add To Cart"

    visit "/cart"

    within "#cart-item-#{@pencil.id}" do
      expect(page).to have_content("1")
      expect(page).to have_link("+1")
      expect(page).to have_link("-1")
      click_on("+1")
      expect(page).to have_content("2")
      click_on("+1")
      expect(page).to have_content("3")
      click_on("-1")
      expect(page).to have_content("2")
      click_on("-1")
      expect(page).to have_content("1")
      click_on("-1")
    end

    expect(page).to have_no_content(@pencil.name)
  end
end
