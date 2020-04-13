class Merchant::ItemsController < Merchant::BaseController

  def index
    @merchant = Merchant.find(current_user[:merchant_id])
  end

  def new
    @merchant = Merchant.find(current_user[:merchant_id])
  end

  def add_item
    @merchant = Merchant.find(current_user[:merchant_id])
    item = @merchant.items.new(item_params)
    if item.save
      flash[:notice] = "#{item.name} has been added to your catalog."
      redirect_to "/merchant/items"
    else
      flash[:notice] = "Unable to add item: #{item.errors.full_messages.to_sentence}."
      render :new
    end
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

  def destroy
    item = Item.destroy(params[:id])
    flash[:notice] = "#{item.name} has been removed from your inventory."
    redirect_to "/merchant/items"
  end

  private

  def item_params
    params[:image] = "https://www.thesun.co.uk/wp-content/uploads/2018/11/cat-2.png" unless params[:image] != ""
    params.permit(:name, :description, :price, :image, :inventory)
  end

end
