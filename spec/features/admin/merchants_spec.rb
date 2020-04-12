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



    it "I see all merchants in the system" do
      admin = User.create(name: "David", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 3)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit "/admin/merchants"



      within "#merchant-#{@mike.id}" do
        expect(page).to have_link(@mike.name)
        expect(page).to have_content(@mike.address)
        expect(page).to have_content(@mike.city)
        expect(page).to have_content(@mike.state)
        expect(page).to have_content(@mike.zip)
      end

      within "#merchant-#{@bike_shop.id}" do
        expect(page).to have_link(@bike_shop.name)
        expect(page).to have_content(@bike_shop.address)
        expect(page).to have_content(@bike_shop.city)
        expect(page).to have_content(@bike_shop.state)
        expect(page).to have_content(@bike_shop.zip)
      end

      within "#merchant-#{@dog_shop.id}" do
        expect(page).to have_link(@dog_shop.name)
        expect(page).to have_content(@dog_shop.address)
        expect(page).to have_content(@dog_shop.city)
        expect(page).to have_content(@dog_shop.state)
        expect(page).to have_content(@dog_shop.zip)
      end

    end

    it "I can see a single merchant" do
      admin = User.create(name: "David", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 3)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit "/admin/merchants"

      within "#merchant-#{@mike.id}" do
        expect(page).to have_link(@mike.name)
        click_on @mike.name
      end
      expect(current_path).to eq("/admin/merchants/#{@mike.id}")

      expect(page).to have_content(@mike.name)
      expect(page).to have_content(@mike.address)
      expect(page).to have_content(@mike.city)
      expect(page).to have_content(@mike.state)
      expect(page).to have_content(@mike.zip)
    end

    it "I can revoke a merchant" do
      admin = User.create(name: "David", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 3)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit "/admin/merchants"

      within "#merchant-#{@mike.id}" do
        expect(page).to have_link('Disable')
        click_on 'Disable'
      end
      expect(current_path).to eq("/admin/merchants")

      expect(page).to have_content("#{@mike.name} is now disabled.")
    end

    it "I can revoke a merchant" do
      admin = User.create(name: "David", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 3)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit "/admin/merchants"

      within "#merchant-#{@mike.id}" do
        expect(page).to have_link('Disable')
        click_on 'Disable'
      end
      visit "/items/#{@paper.id}"
      expect(page).to have_content("Inactive")
    end
  end
end
