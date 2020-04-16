class Admin::MerchantsController < Admin::BaseController

  def show
    @merchant = Merchant.find(params[:id])
  end

  def index
    @merchants = Merchant.all
  end

  def new
  end

  def create
    merchant = Merchant.create(merchant_params)
    if merchant.save
      flash[:success] = "#{merchant.name} was successfully created."
      redirect_to "/admin/merchants"
    else
      flash[:error] = "Unable to create merchant; #{merchant.errors.full_messages.to_sentence}"
      render :new
    end
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update_merchant
    @merchant = Merchant.find(params[:id])
    @merchant.update(merchant_params)
    if @merchant.save
      flash[:success] = "Merchant has successfully been updated."
      redirect_to "/admin/merchants/#{@merchant.id}"
    else
      flash[:error] = "Unable to update merchant; #{@merchant.errors.full_messages.to_sentence}."
      render :edit
    end
  end

  def update
    order = Order.find (params[:id])
    order.status = "Shipped"
    order.save
    redirect_to '/admin'
  end

  def status
    merchant = Merchant.find(params[:id])
    if merchant.status == true
      merchant.status = false
      merchant.items_status(false)
      flash[:success] = "#{merchant.name} is now disabled."
    else
      merchant.status = true
      merchant.items_status(true)
      flash[:success] = "#{merchant.name} is now enabled."
    end
    merchant.save
    redirect_to '/admin/merchants'
  end

  def destroy
    merchant = Merchant.find(params[:id])
    merchant.destroy
    flash[:success] = "Successfully deleted #{merchant.name}"
    redirect_to '/admin/merchants'
  end

  private

  def merchant_params
    params.permit(:name,:address,:city,:state,:zip)
  end
end
