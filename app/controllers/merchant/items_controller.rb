class Merchant::ItemsController < Merchant::BaseController
  def index
    @merchant = Merchant.find(current_user[:merchant_id])
  end

  def update_active
    item = Item.find(params[:id])
    if item.active?
      item.update(active?: false)
      flash[:notice] = "#{item.name} is no longer for sale."
    elsif !item.active?
      item.update(active?: true)
      flash[:notice] = "#{item.name} is now for sale."
    end
      redirect_to "/merchant/items"
  end

end
