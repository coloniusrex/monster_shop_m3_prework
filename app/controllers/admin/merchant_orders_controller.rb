class Admin::MerchantOrdersController < Admin::BaseController
  def update
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:item_id])
    order = Order.find(params[:order_id])
    item_order = ItemOrder.where(item_id:params[:item_id], order_id:params[:order_id])
    amount = item.inventory - order.amount_wanted(params[:item_id])
    item.update_attribute(:inventory, amount)
    item_order[0].update_attributes(:status => "Fulfilled", quantity: 0)
    item_order[0].save
    if item.save
      flash[:notice] = "#{item.name} inventory has been subtract to fulfill the order."
      redirect_to "/admin/merchants/#{merchant.id}/merchant_orders/#{order.id}"
    end
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @order = Order.find(params[:id])
  end
end
