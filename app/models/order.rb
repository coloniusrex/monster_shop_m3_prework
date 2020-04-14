class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip

  has_many :item_orders
  has_many :items, through: :item_orders
  belongs_to :user

  def grandtotal
    item_orders.sum('price * quantity')
  end

  def find_user
    User.find(self.user_id).name
  end

  def total_quantity
    item_orders.sum(:quantity)
  end

  def merchant_total_items(merchant)
    my_items = items.where(merchant_id:merchant.id)
    item_orders.where(item_id:my_items).sum(:quantity)
  end

  def merchant_total_cost(merchant)
    my_items = items.where(merchant_id:merchant.id)
    my_item_orders = item_orders.where(item_id:my_items)
    total = 0
    my_item_orders.each do |item_order|
      total += item_order.subtotal
    end
    total
  end


  def amount_wanted(item)
    item_order = item_orders.where(item_id:item)
    item_order[0].quantity
  end

  def merchant_specific_items(current_user)
    merchant_items = Merchant.find(current_user[:merchant_id]).items
    item_orders.where(item_id: merchant_items)

  end

end
