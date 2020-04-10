require 'rails_helper'

RSpec.describe 'Site Navigation' do
  describe 'As a Admin' do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @dog_bone = @brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 20, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
      @user1 = User.create(name: "David", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 1)
      @user2 = User.create(name: "Bob", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 1)

      @order_1 = @user1.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, status: 'Packaged')
      @order_2 = @user1.orders.create!(name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80204)
      @order_3 = @user2.orders.create!(name: 'Mike', address: '123 Dao St', city: 'Denver', state: 'CO', zip: 80210, status: 'Shipped')
      @order_4 = @user2.orders.create!(name: 'Mike', address: '123 Dao St', city: 'Denver', state: 'CO', zip: 80210, status: 'Cancelled')

      @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
      @order_1.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 3)
      @order_2.item_orders.create!(item: @dog_bone, price: @dog_bone.price, quantity: 2)
      @order_2.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 2)
      @order_2.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
      @order_3.item_orders.create!(item: @dog_bone, price: @dog_bone.price, quantity: 5)
      @order_4.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
      @order_4.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 3)


    end
    it "I see all orders in the system" do
      admin = User.create(name: "David", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 3)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit '/admin'
      within '#Packaged' do
        expect(page).to have_content(@user1.name)
        expect(page).to have_content(@order_1.id)
        expect(page).to have_content(@order_1.created_at)
      end
      within '#Pending' do
        expect(page).to have_content(@user1.name)
        expect(page).to have_content(@order_2.id)
        expect(page).to have_content(@order_2.created_at)
      end
      within '#Shipped' do
        expect(page).to have_content(@user2.name)
        expect(page).to have_content(@order_3.id)
        expect(page).to have_content(@order_3.created_at)
      end
      within '#Cancelled' do
        expect(page).to have_content(@user2.name)
        expect(page).to have_content(@order_4.id)
        expect(page).to have_content(@order_4.created_at)
      end
    end
  end
end
