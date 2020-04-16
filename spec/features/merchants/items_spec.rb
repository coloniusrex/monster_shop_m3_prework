require 'rails_helper'

describe "merchant item index" do
  before(:each) do
    @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @merchant_1 = User.create(name: "Mike Dao", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "thedao@example.com", password: "password", role: 2)
    @mike.add_employee(@merchant_1)
  end

  it "can add items with proper fields" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)

    visit "/merchant/items"
    click_link("Add Item")
    expect(current_path).to eq("/merchant/items/new")

    name = "Test Item"
    fill_in :name, with: name
    fill_in :description, with: "Test Description"
    fill_in :price, with: 17
    fill_in :inventory, with: 17

    click_on "Add Item"
    expect(current_path).to eq("/merchant/items")
    expect(page).to have_content("#{name} has been added to your catalog.")
    within(".items-list") do
      expect(page).to have_content("Name: #{name}")
      expect(page).to have_content("Description: Test Description")
      expect(page).to have_content("Price: $17")
      expect(page).to have_content("Inventory: 17")
    end
  end

  it "can't add items without proper fields" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)
    visit "/merchant/items"
    click_link("Add Item")

    fill_in :description, with: "Test Description"
    fill_in :image, with: "https://www.thesun.co.uk/wp-content/uploads/2018/11/cat-2.png"
    fill_in :price, with: 17
    fill_in :inventory, with: 17

    click_on "Add Item"
    expect(page).to have_content("Unable to add item: Name can't be blank.")

    expect(find_field('Description').value).to eql("Test Description")
    expect(find_field('image').value).to eql("https://www.thesun.co.uk/wp-content/uploads/2018/11/cat-2.png")
    expect(find_field('price').value).to eql("17")
    expect(find_field('inventory').value).to eql("17")
  end
end
