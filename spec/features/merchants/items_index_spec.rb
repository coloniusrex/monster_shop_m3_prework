require 'rails_helper'

describe "merchant items" do
  before(:each) do
    @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @merchant_1 = User.create(name: "Mike Dao", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "thedao@example.com", password: "password", role: 2)
    @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 25)
    @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
    @mike.add_employee(@merchant_1)
  end

  it "can activate/deactive items" do

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)
    visit "/merchant/items/"

    within(".items-list") do
      expect(page).to have_content(@pencil.name)
      within("#item-#{@paper.id}") do
        expect(page).to have_content("Name: #{@paper.name}")
        expect(page).to have_content("Description: #{@paper.description}")
        expect(page).to have_content("Price: $#{@paper.price}")
        expect(page).to have_content("Active?: true")
        expect(page).to have_content("Inventory: #{@paper.inventory}")
        click_link("Deactivate Item")
      end
    end

    expect(current_path).to eq("/merchant/items")
    expect(page).to have_content("#{@paper.name} is no longer for sale.")
    within("#item-#{@paper.id}") do
      expect(page).to have_content("Name: #{@paper.name}")
      expect(page).to have_content("Description: #{@paper.description}")
      expect(page).to have_content("Price: $#{@paper.price}")
      expect(page).to have_content("Active?: false")
      expect(page).to have_content("Inventory: #{@paper.inventory}")

      click_link("Activate Item")
      expect(page).to have_content("Active?: true")
    end

    expect(page).to have_content("#{@paper.name} is now for sale.")
  end

  it "can delete an item if it's never been ordered" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)
    visit "/merchant/items/"

    within(".items-list") do
      expect(page).to have_content(@pencil.name)

      within("#item-#{@paper.id}") do
        expect(page).to have_content(@paper.name)
        click_link("Delete Item")
      end

      expect(current_path).to eq("/merchant/items")
      expect(page).to have_no_content(@paper.name)
      expect(page).to have_content(@pencil.name)
    end

    expect(page).to have_content("#{@paper.name} has been removed from your inventory.")
  end

  it "can't delete an item if it has been ordered" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)

    order_1 = @merchant_1.orders.create(id: 3, name: "Colin", address: "400 Wash", city: "Denver", state: "CO", zip: 80203)
    order_1.item_orders.create(order_id: order_1.id, item: @paper, quantity: 2, price: @paper.price)

    visit "/merchant/items"

    within("#item-#{@pencil.id}") do
      expect(page).to have_link("Delete Item")
    end

    within("#item-#{@paper.id}") do
      expect(page).to have_no_link("Delete Item")
    end
  end
end
