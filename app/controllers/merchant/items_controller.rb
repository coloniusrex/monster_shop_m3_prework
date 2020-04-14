class Merchant::ItemsController < Merchant::BaseController

  def index
    @merchant = Merchant.find(current_user[:merchant_id])
  end

  def new
    @merchant = Merchant.find(current_user[:merchant_id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      @item.save
      flash[:notice] = "Item Succesfully Updated"
      redirect_to "/merchant/items"
    else
      flash[:error] = "Incorrectly filled out #{@item.changed_attributes.keys.join(", ")}, try again."
      @item.restore_attributes
      render :edit
    end
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
    if item.status == true
      item.update(status: false)
      flash[:notice] = "#{item.name} is no longer for sale."
    else
      item.update(status: true)
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
    params.permit(:name,:description,:price,:inventory,:image)
  end

end
