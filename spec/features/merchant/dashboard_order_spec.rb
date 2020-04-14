require 'rails_helper'

describe "merchant dashboard" do
  before(:each) do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
    @merchant_user = User.create(name: "David Tran", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 2)
    @bike_shop.add_employee(@merchant_user)
    @user = User.create(name: "Colin Anderson", address: "456 Wash St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 1)
    @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @rim = @bike_shop.items.create(name: "Rim", description: "Strong spokes.", price: 100, image: "https://cdn10.bigcommerce.com/s-6w6qcuo4/product_images/attribute_rule_images/19719_zoom_1516397191.jpg", inventory: 12)
    @dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    @pull_toy = @dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)

    @order_1 = @user.orders.create(id: 3, name: "Colin Anderson", address: "456 Wash St", city: "Denver", state: "CO", zip: 80203)
    @item_order_1 = @order_1.item_orders.create(order_id: @order_1.id, item: @tire, quantity: 1, price: @tire.price)
    @item_order_2 = @order_1.item_orders.create(order_id: @order_1.id, item: @pull_toy, quantity: 2, price: @pull_toy.price)
  end

  it "displays order information and items sold by that specific merchant" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_user)

    visit "/merchant"

    expect(page).to have_content(@bike_shop.name)
    expect(page).to have_content(@bike_shop.address)

    click_link(@order_1.id)
    expect(page).to have_content(@order_1.name)
    expect(page).to have_content(@order_1.address)
    expect(page).to have_content(@item_order_1.item.name)
    expect(page).to have_content(@item_order_1.quantity)
    expect(page).to have_content(@item_order_1.price)
    expect(page).to have_no_content(@item_order_2.price)
    expect(page).to have_no_content(@item_order_2.item)
  end
end
