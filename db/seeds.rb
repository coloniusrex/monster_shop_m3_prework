ItemOrder.destroy_all
Merchant.destroy_all
Item.destroy_all
Order.destroy_all
User.destroy_all
ItemOrder.destroy_all

#merchants
bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

#bike_shop items
tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
rim = bike_shop.items.create(name: "Rim", description: "Strong spokes.", price: 100, image: "https://cdn10.bigcommerce.com/s-6w6qcuo4/product_images/attribute_rule_images/19719_zoom_1516397191.jpg", inventory: 12)
tire_parts = bike_shop.items.create(name: "Helmet", description: "Protect the noggin'.", price: 100, image: "https://dks.scene7.com/is/image/GolfGalaxy/17BELAPRMSXXXXXXXDLT_Matte_Black_Gunmetal?wid=2000&fmt=pjpeg", inventory: 12)
axle = bike_shop.items.create(name: "Handle Grips", description: "Keep on hangin' on.", price: 100, image: "https://images.amain.com/images/large/bikes/pnw-components/lga25tb.jpg?width=950", inventory: 12)
seat = bike_shop.items.create(name: "Bike Seat", description: "Squishy tushy.", price: 100, image: "https://www.sefiles.net/images/library/zoom/planet-bike-little-a.r.s-bike-seat-231296-1-19-9.jpg", inventory: 12)

#dog_shop items
pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
dog_bone = dog_shop.items.create(name: "Dog Bone", description: "Bonified fun!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
chew_rope = dog_shop.items.create(name: "Chew Rope", description: "Laffy Lasso", price: 21, image: "https://ae01.alicdn.com/kf/HTB1G1JIMXXXXXa8XVXXq6xXFXXXv/Free-Shipping-Cotton-Rope-Pet-Dog-toy-Multicolor-For-Puppy-Double-Knot-Chew-Toy-Durable-Braided.jpg", inventory: 21)
squeaky_toy = dog_shop.items.create(name: "Squeaky Toy", description: "Dogs love it. Humans hate it.", price: 21, image: "https://i.pinimg.com/originals/90/7e/13/907e138fc1e8401dcedabb795d07fd67.jpg", inventory: 21)
kong_toy = dog_shop.items.create(name: "Kong Toy", description: "They paid us to say that.", price: 21, image: "https://www.dogtuff.com/media/catalog/product/cache/e4d64343b1bc593f1c5348fe05efa4a6/k/o/kong_classic_red_xxl_pkg.jpg", inventory: 21)

#users

user = User.create(name: "User", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "user@example.com", password: "password_regular", role: 1)
merchant = User.create(name: "Merchant", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "merchant@example.com", password: "password_merchant", role: 2)
admin = User.create(name: "Admin", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "admin@example.com", password: "password_admin", role: 3)

merchant_1 = User.create(name: "Merchant", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "merchant@example.com", password: "merchant", role: 2)
merchant_2 = User.create(name: "Merchant", address: "123 Test St", city: "Denver", state: "CO", zip: "80204", email: "merchant2@example.com", password: "merchant", role: 2)

#employees
bike_shop.add_employee(merchant_1)
dog_shop.add_employee(merchant_2)

#orders
order1 = user.orders.create(id: 3, name: "Colin", address: "400 Wash", city: "Denver", state: "CO", zip: 80203)
order1.item_orders.create(order_id: order1.id, item: pull_toy, quantity: 1, price: pull_toy.price)
order1.item_orders.create(order_id: order1.id, item: dog_bone, quantity: 2, price: dog_bone.price)
order1.item_orders.create(order_id: order1.id, item: tire, quantity: 3, price: tire.price)
order1.item_orders.create(order_id: order1.id, item: rim, quantity: 4, price: rim.price)
order1.item_orders.create(order_id: order1.id, item: chew_rope, quantity: 5, price: chew_rope.price)
order1.item_orders.create(order_id: order1.id, item: squeaky_toy, quantity: 6, price: squeaky_toy.price)
order1.item_orders.create(order_id: order1.id, item: kong_toy, quantity: 7, price: kong_toy.price)
order1.item_orders.create(order_id: order1.id, item: tire_parts, quantity: 8, price: tire_parts.price)
order1.item_orders.create(order_id: order1.id, item: axle, quantity: 9, price: axle.price)
order1.item_orders.create(order_id: order1.id, item: seat, quantity: 10, price: seat.price)

order2 = user.orders.create(id: 4, name: "Colin", address: "400 Wash", city: "Denver", state: "CO", zip: 80203, status: "Shipped")

order2.item_orders.create(order_id: order1.id, item: pull_toy, quantity: 1, price: pull_toy.price)
order2.item_orders.create(order_id: order1.id, item: dog_bone, quantity: 2, price: dog_bone.price)
order2.item_orders.create(order_id: order1.id, item: tire, quantity: 3, price: tire.price)
order2.item_orders.create(order_id: order1.id, item: rim, quantity: 4, price: rim.price)
order2.item_orders.create(order_id: order1.id, item: chew_rope, quantity: 5, price: chew_rope.price)

order3 = user.orders.create(id: 5, name: "Colin", address: "400 Wash", city: "Denver", state: "CO", zip: 80203, status: "Packaged")

order3.item_orders.create(order_id: order1.id, item: pull_toy, quantity: 1, price: pull_toy.price)
order3.item_orders.create(order_id: order1.id, item: dog_bone, quantity: 2, price: dog_bone.price)
order3.item_orders.create(order_id: order1.id, item: tire, quantity: 3, price: tire.price)
order3.item_orders.create(order_id: order1.id, item: axle, quantity: 9, price: axle.price)
order3.item_orders.create(order_id: order1.id, item: seat, quantity: 10, price: seat.price)
