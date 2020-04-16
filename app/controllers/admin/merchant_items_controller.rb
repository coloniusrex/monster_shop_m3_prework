class Admin::MerchantItemsController < Admin::BaseController

  def index
    @merchant = Merchant.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    if @item.update(item_params)
      @item.save
      flash[:success] = "Item Succesfully Updated"
      redirect_to "/admin/merchants/#{@merchant.id}/items"
    else
      flash[:error] = "Incorrectly filled out #{@item.changed_attributes.keys.join(", ")}, try again."
      @item.restore_attributes
      render :edit
    end
  end

  def create
    @merchant = Merchant.find(params[:id])
    item = @merchant.items.new(item_params)
    if item.save
      flash[:success] = "#{item.name} has been added to your catalog."
      redirect_to "/admin/merchants/#{@merchant.id}/items"
    else
      flash[:success] = "Unable to add item: #{item.errors.full_messages.to_sentence}."
      render :new
    end
  end

  def update_active
    @merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:id])
    if item.status == true
      item.update(status: false)
      flash[:success] = "#{item.name} is no longer for sale."
    else
      item.update(status: true)
      flash[:success] = "#{item.name} is now for sale."
    end
    redirect_to "/admin/merchants/#{@merchant.id}/items"
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    item = Item.destroy(params[:id])
    flash[:success] = "#{item.name} has been removed from your inventory."
    redirect_to "/admin/merchants/#{merchant.id}/items"
  end

  private

  def item_params
    params[:image] = "https://www.thesun.co.uk/wp-content/uploads/2018/11/cat-2.png" unless params[:image] != ""
    params.permit(:name,:description,:price,:inventory,:image)
  end
end
