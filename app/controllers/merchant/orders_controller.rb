class Merchant::OrdersController < Merchant::BaseController

  def update
    item = Item.find(params[:item_id])
    order = Order.find(params[:order_id])
    item_order = ItemOrder.where(item_id:params[:item_id], order_id:params[:order_id])
    amount = item.inventory - order.amount_wanted(params[:item_id])
    item.update_attribute(:inventory, amount)
    item_order[0].update_attributes(:status => "Fulfilled", quantity: 0)
    item_order[0].save
    if item.save
      flash[:notice] = "#{item.name} inventory has been subtract to fulfill the order."
      redirect_to "/merchant/orders/#{order.id}"
    end
  end

  def show
    @order = Order.find(params[:id])
  end

end
