require 'rails_helper'

RSpec.describe "Items Index Page" do
  describe "When I visit the items index page" do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @dog_bone = @brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
    end

    it "all items or merchant names are links" do
      visit '/items'

      expect(page).to have_link(@tire.name)
      expect(page).to have_link(@tire.merchant.name)
      expect(page).to have_link(@pull_toy.name)
      expect(page).to have_link(@pull_toy.merchant.name)
      expect(page).to have_no_css("#item-#{@dog_bone.id}")
    end

    it "all item images are links" do
      visit '/items'

      expect(page).to have_link("#{@tire.id}_image")
      expect(page).to have_link("#{@pull_toy.id}_image")
      expect(page).to have_no_link("#{@dog_bone.id}_image")
    end

    it "I can see a list of all of the items "do

      visit '/items'

      within "#item-#{@tire.id}" do
        expect(page).to have_link(@tire.name)
        expect(page).to have_content(@tire.description)
        expect(page).to have_content("Price: $#{@tire.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@tire.inventory}")
        expect(page).to have_link(@meg.name)
        expect(page).to have_css("img[src*='#{@tire.image}']")
      end

      within "#item-#{@pull_toy.id}" do
        expect(page).to have_link(@pull_toy.name)
        expect(page).to have_content(@pull_toy.description)
        expect(page).to have_content("Price: $#{@pull_toy.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@pull_toy.inventory}")
        expect(page).to have_link(@brian.name)
        expect(page).to have_css("img[src*='#{@pull_toy.image}']")
      end
      expect(page).to have_no_css("#item-#{@dog_bone.id}")
    end

    it "As any kind of user on the system, I can see all items except disabled items" do
      user = User.create(name: "David", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 1)
      merchant = User.create(name: "Colin", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "456@example.com", password: "password", role: 2)
      admin = User.create(name: "Max", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "789@example.com", password: "password", role: 3)

      visit "/items"

      expect(page).to have_link(@tire.name)
      expect(page).to have_link(@pull_toy.name)

      expect(page).to have_no_link(@dog_bone.name)

      visit '/login'

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_on 'Login'

      visit "/items"

      expect(page).to have_link(@tire.name)
      expect(page).to have_link(@pull_toy.name)
      expect(page).to have_no_link(@dog_bone.name)

      click_on 'Logout'

      visit '/login'

      fill_in :email, with: merchant.email
      fill_in :password, with: merchant.password

      click_on 'Login'

      visit "/items"

      expect(page).to have_link(@tire.name)
      expect(page).to have_link(@pull_toy.name)
      expect(page).to have_no_link(@dog_bone.name)

      click_on 'Logout'

      visit '/login'

      fill_in :email, with: admin.email
      fill_in :password, with: admin.password

      click_on 'Login'

      visit "/items"

      expect(page).to have_link(@tire.name)
      expect(page).to have_link(@pull_toy.name)
      expect(page).to have_no_link(@dog_bone.name)

    end

    it "As any user of the index page, I can see top & bottom 5 popular items" do
      bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      #bike_shop items
      tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      rim = bike_shop.items.create(name: "Shiny Wheel", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      tire_parts = bike_shop.items.create(name: "Parts for Wheels", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      axle = bike_shop.items.create(name: "Wheel Axle", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      seat = bike_shop.items.create(name: "Bike Seat", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

      #dog_shop items
      pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
      chew_rope = dog_shop.items.create(name: "Chew Rope", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
      squeaky_toy = dog_shop.items.create(name: "Squeaky Toy", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
      kong_toy = dog_shop.items.create(name: "Kong Toy", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

      user = User.create(name: "David", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "123@example.com", password: "password", role: 1)
      order1 = user.orders.create(id: 3, name: "Colin", address: "400 Wash", city: "Denver", state: "CO", zip: 80203)

      item_order1 = ItemOrder.create(order_id: order1.id, item: pull_toy, quantity: 1, price: pull_toy.price)
      item_order2 = ItemOrder.create(order_id: order1.id, item: dog_bone, quantity: 2, price: dog_bone.price)
      item_order3 = ItemOrder.create(order_id: order1.id, item: tire, quantity: 3, price: tire.price)
      item_order4 = ItemOrder.create(order_id: order1.id, item: rim, quantity: 4, price: rim.price)
      item_order5 = ItemOrder.create(order_id: order1.id, item: chew_rope, quantity: 5, price: chew_rope.price)
      item_order6 = ItemOrder.create(order_id: order1.id, item: squeaky_toy, quantity: 6, price: squeaky_toy.price)
      item_order7 = ItemOrder.create(order_id: order1.id, item: kong_toy, quantity: 7, price: kong_toy.price)
      item_order8 = ItemOrder.create(order_id: order1.id, item: tire_parts, quantity: 8, price: tire_parts.price)
      item_order9 = ItemOrder.create(order_id: order1.id, item: axle, quantity: 9, price: axle.price)
      item_order10 = ItemOrder.create(order_id: order1.id, item: seat, quantity: 10, price: seat.price)

      visit '/items'

      within('.statistics') do
        within('#most-popular') do
          expect("#{seat.name}: #{item_order10.quantity}").to appear_before("#{axle.name}: #{item_order9.quantity}")
          expect("#{axle.name}: #{item_order9.quantity}").to appear_before("#{tire_parts.name}: #{item_order8.quantity}")
          expect("#{tire_parts.name}: #{item_order8.quantity}").to appear_before("#{kong_toy.name}: #{item_order7.quantity}")
          expect("#{kong_toy.name}: #{item_order7.quantity}").to appear_before("#{squeaky_toy.name}: #{item_order6.quantity}")
        end
        within('#least-popular') do
          expect("#{pull_toy.name}: #{item_order1.quantity}").to appear_before("#{dog_bone.name}: #{item_order2.quantity}")
          expect("#{dog_bone.name}: #{item_order2.quantity}").to appear_before("#{tire.name}: #{item_order3.quantity}")
          expect("#{tire.name}: #{item_order3.quantity}").to appear_before("#{rim.name}: #{item_order4.quantity}")
          expect("#{rim.name}: #{item_order4.quantity}").to appear_before("#{chew_rope.name}: #{item_order5.quantity}")
        end
      end
    end
  end
end
# As any kind of user on the system
# When I visit the items index page ("/items")
# I see an area with statistics:
# - the top 5 most popular items by quantity purchased, plus the quantity bought
# - the bottom 5 least popular items, plus the quantity bought
#
# "Popularity" is determined by total quantity of that item ordered
