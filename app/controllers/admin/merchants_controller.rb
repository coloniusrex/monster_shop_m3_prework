class Admin::MerchantsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:id])
  end

  def index
    @merchants = Merchant.all
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
      flash[:notice] = "#{merchant.name} is now disabled."
    else
      merchant.status = true
      merchant.items_status(true)
      flash[:notice] = "#{merchant.name} is now enabled."
    end
    merchant.save
    redirect_to '/admin/merchants'
  end
end
