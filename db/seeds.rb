# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ItemOrder.destroy_all
Merchant.destroy_all
Item.destroy_all
User.destroy_all

#merchants
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

#users

user = User.create(name: "User", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "user@example.com", password: "user", role: 1)
merchant = User.create(name: "Merchant", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "merchant@example.com", password: "merchant", role: 2)
admin = User.create(name: "Admin", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "admin@example.com", password: "admin", role: 3)

order1 = Order.create(id: 3, name: "Colin", address: "400 Wash", city: "Denver", state: "CO", zip: 80203)

ItemOrder.create(order_id: order1.id, item: pull_toy, quantity: 1, price: pull_toy.price)
ItemOrder.create(order_id: order1.id, item: dog_bone, quantity: 2, price: dog_bone.price)
ItemOrder.create(order_id: order1.id, item: tire, quantity: 3, price: tire.price)
ItemOrder.create(order_id: order1.id, item: rim, quantity: 4, price: rim.price)
ItemOrder.create(order_id: order1.id, item: chew_rope, quantity: 5, price: chew_rope.price)
ItemOrder.create(order_id: order1.id, item: squeaky_toy, quantity: 6, price: squeaky_toy.price)
ItemOrder.create(order_id: order1.id, item: kong_toy, quantity: 7, price: kong_toy.price)
ItemOrder.create(order_id: order1.id, item: tire_parts, quantity: 8, price: tire_parts.price)
ItemOrder.create(order_id: order1.id, item: axle, quantity: 9, price: axle.price)
ItemOrder.create(order_id: order1.id, item: seat, quantity: 10, price: seat.price)
