require 'rails_helper'

RSpec.describe 'Admin merchants index' do
  describe 'When I visit admin/merchants I see a list of merchants' do

    before(:each) do
      @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
      @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 25)
      @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)

    end



    it "I can add this item to my cart" do
      visit "/admin/merchants"


      within "#merchant-#{@mike.id}" do
        expect(page).to have_content(@mike.name)
        expect(page).to have_content(@mike.address)
        expect(page).to have_content(@mike.city)
        expect(page).to have_content(@mike.state)
        expect(page).to have_content(@mike.zip)
      end

      within "#merchant-#{@bike_shop.id}" do
        expect(page).to have_content(@bike_shop.name)
        expect(page).to have_content(@bike_shop.address)
        expect(page).to have_content(@bike_shop.city)
        expect(page).to have_content(@bike_shop.state)
        expect(page).to have_content(@bike_shop.zip)
      end

      within "#merchant-#{@dog_shop.id}" do
        expect(page).to have_content(@dog_shop.name)
        expect(page).to have_content(@dog_shop.address)
        expect(page).to have_content(@dog_shop.city)
        expect(page).to have_content(@dog_shop.state)
        expect(page).to have_content(@dog_shop.zip)
      end

    end
  end
end
