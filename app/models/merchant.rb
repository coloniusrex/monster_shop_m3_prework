class Merchant <ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :item_orders, through: :items

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip,
                        :status


  def no_orders?
    item_orders.empty?
  end

  def item_count
    items.count
  end

  def average_item_price
    items.average(:price)
  end

  def distinct_cities
    item_orders.distinct.joins(:order).pluck(:city)
  end

  def items_status(boolean_value)
    items.each do |item|
      if !(boolean_value == false && item.status == false)
        item.status = boolean_value
        item.save
      end
    end
  end

end
