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

    it "I a merchants items are disabled when the merchant is disabled" do
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

    it "I an enable a merchant" do
      admin = User.create(name: "David", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 3)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit "/admin/merchants"

      within "#merchant-#{@mike.id}" do
        expect(page).to have_link('Disable')
        click_on 'Disable'
      end

      within "#merchant-#{@mike.id}" do
        expect(page).to have_link('Enable')
        click_on 'Enable'
      end

      expect(current_path).to eq("/admin/merchants")
      expect(page).to have_content("#{@mike.name} is now enabled.")

    end

    it "I re-enable a merchant items that are disabled" do
      admin = User.create(name: "David", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 3)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit "/admin/merchants"

      within "#merchant-#{@mike.id}" do
        expect(page).to have_link('Disable')
        click_on 'Disable'
      end
      visit "/items/#{@paper.id}"
      expect(page).to have_content("Inactive")

      visit "/admin/merchants"
      within "#merchant-#{@mike.id}" do
        expect(page).to have_link('Enable')
        click_on 'Enable'
      end

      visit "/items/#{@paper.id}"
      expect(page).to have_content("Active")
    end

    it "can delete a merchant" do
      admin = User.create(name: "David", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 3)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit "/admin/merchants/#{@mike.id}"

      click_on("Delete Merchant")

      expect(current_path).to eq("/admin/merchants")
      expect(page).to have_content("Successfully deleted #{@mike.name}")
    end

    it "can update a merchant" do
      admin = User.create(name: "David", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 3)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit "/admin/merchants/#{@mike.id}"
      click_on("Update Merchant")
      fill_in :name, with: ""
      click_on "Update Merchant"

      expect(page).to have_content("Unable to update merchant; Name can't be blank.")

      fill_in :name, with: "Test"
      click_on("Update Merchant")

      expect(current_path).to eq("/admin/merchants/#{@mike.id}")
      expect(page).to have_content("Merchant has successfully been updated.")
      expect(page).to have_no_content("Mike's Print Shop")
      expect(page).to have_content("Test")
    end

    it "can create a merchant" do
      admin = User.create(name: "David", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 3)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit "/admin/merchants"
      click_on("Create Merchant")
      fill_in :name, with: ""
      fill_in :address, with: "Test"
      fill_in :city, with: "Test"
      fill_in :state, with: "Test"
      fill_in :zip, with: "Test"
      click_on("Create Merchant")

      expect(page).to have_content("Unable to create merchant; Name can't be blank")
      fill_in :name, with: "Test"
      fill_in :address, with: "Test"
      fill_in :city, with: "Test"
      fill_in :state, with: "Test"
      fill_in :zip, with: "Test"
      click_on("Create Merchant")

      expect(current_path).to eq("/admin/merchants")
      expect(page).to have_content("Test was successfully created.")
    end

    it "can fulfill orders for merchants" do
      dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Charlesville', state: 'MS', zip: 80210)
      pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 25)
      dog_bone = dog_shop.items.create(name: "Dog Bone", description: "Bonified fun!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", status: false, inventory: 30)
      user = User.create(name: "User(Colin)", address: "123 Test St", city: "New York", state: "NY", zip: "80204", email: "user@example.com", password: "user", role: 1)
      order1 = user.orders.create(id: 3, name: "Colin", address: "400 Wash", city: "Denver", state: "CO", zip: 80203)
      item_order_1 = order1.item_orders.create(order_id: order1.id, item: pull_toy, quantity: 1, price: pull_toy.price)
      order1.item_orders.create(order_id: order1.id, item: dog_bone, quantity: 2, price: dog_bone.price)

      admin = User.create(name: "David", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 3)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit "/admin/merchants/#{dog_shop.id}/merchant_orders/#{order1.id}"
      within("#item-#{item_order_1.item.id}") do
        click_on "Fulfill"
      end
      expect(current_path).to eq("/admin/merchants/#{dog_shop.id}/merchant_orders/#{order1.id}")
    end
  end
end
