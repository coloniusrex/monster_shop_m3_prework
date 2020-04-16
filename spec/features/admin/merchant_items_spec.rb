require 'rails_helper'

describe "as an admin visiting merchants/:id/items" do
  it "can create an item" do
    admin = User.create(name: "David", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 3)
    mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    paper = mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 25)
    pencil = mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/merchants/#{mike.id}/merchant_items"

    click_link("Create Item")

    fill_in :name, with: ""
    fill_in :description, with: "Test"
    fill_in :price, with: 7
    fill_in :inventory, with: 10

    click_on "Create Item"

    expect(page).to have_content("Unable to add item: Name can't be blank.")

    fill_in :name, with: "Test"
    fill_in :description, with: "Test"
    fill_in :price, with: 7
    fill_in :inventory, with: 10
    click_on "Create Item"

    expect(current_path).to eq("/admin/merchants/#{mike.id}/merchant_items")
    within(".items-list") do
      expect(page).to have_content(paper.name)
      expect(page).to have_content(pencil.name)
      expect(page).to have_content("Test")
    end
  end

  it "can edit an item" do
    admin = User.create(name: "David", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 3)
    mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    paper = mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 25)
    pencil = mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/merchants/#{mike.id}/merchant_items"

    within "#item-#{paper.id}" do
      click_on("Edit Item")
    end

    fill_in :name, with: ""
    click_on("Save Item")

    expect(page).to have_content("Incorrectly filled out name, try again.")
    fill_in :name, with: "Test"
    click_on("Save Item")

    expect(page).to have_content("Item Succesfully Updated")
    expect(page).to have_no_content("Lined Paper")
    expect(page).to have_content("Test")
  end

  it "can delete an item" do
    admin = User.create(name: "David", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 3)
    mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    paper = mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 25)
    pencil = mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/merchants/#{mike.id}/merchant_items"
    expect(page).to have_content(paper.name)

    within "#item-#{paper.id}" do
      click_on("Delete Item")
    end

    within ".items-list" do
      expect(page).to have_no_content(paper.name)
    end
  end

  it "can activate/deactivate an item" do
    admin = User.create(name: "David", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 3)
    mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    paper = mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 25)
    pencil = mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/merchants/#{mike.id}/merchant_items"
    expect(page).to have_content(paper.name)

    within "#item-#{paper.id}" do
      expect(page).to have_content("Active?: true")
      expect(page).to have_link("Deactivate Item")
      click_on("Deactivate Item")
      expect(page).to have_content("Active?: false")
      expect(page).to have_link("Activate Item")
      click_on("Activate Item")
      expect(page).to have_content("Active?: true")
    end
  end
end
