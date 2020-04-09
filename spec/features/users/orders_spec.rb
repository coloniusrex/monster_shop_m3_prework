require 'rails_helper'

describe "user orders" do
  it "can cancel an order" do
    user = User.create(name: "David", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 1)
    meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

    tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 0)
    pull_toy = brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 0)

    order_1 = user.orders.create(name: 'David', address: '123 Test St', city: 'Hershey', state: 'PA', zip: 17033, status: "Packaged")
    item_order_1 = order_1.item_orders.create(item: tire, price: tire.price, quantity: 2, status: "Fulfilled")
    item_order_2 = order_1.item_orders.create(item: pull_toy, price: pull_toy.price, quantity: 3, status: "Fulfilled")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/profile/orders/#{order_1.id}"

    click_link("Cancel Order")

    expect(current_path).to eq("/profile")
    expect(page).to have_content("Your order has been canceled.")
    expect(order_1.reload.status).to eq("Canceled")
    expect(item_order_1.reload.status).to eq("Unfulfilled")
    expect(tire.reload.inventory).to eq(2)
    expect(pull_toy.reload.inventory).to eq(3)
  end

  it "updates when all items are fulfilled" do
    user = User.create(name: "David", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 1)
    meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

    tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 0)
    pull_toy = brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 0)

    order_1 = user.orders.create(name: 'David', address: '123 Test St', city: 'Hershey', state: 'PA', zip: 17033, status: "Pending")
    item_order_1 = order_1.item_orders.create(item: tire, price: tire.price, quantity: 2, status: "Fulfilled")
    item_order_2 = order_1.item_orders.create(item: pull_toy, price: pull_toy.price, quantity: 3, status: "Unfulfilled")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/profile/orders/#{order_1.id}"

    within(".shipping-address") do
      expect(page).to have_content("Pending")
    end

    within("#item-#{item_order_2.item_id}") do
      expect(page).to have_content("Unfulfilled")
    end

    item_order_2.update(status: "Fulfilled")
    item_order_2.save

    visit "/profile/orders/#{order_1.id}"

    within(".shipping-address") do
      expect(page).to have_content("Packaged")
    end
  end
end
