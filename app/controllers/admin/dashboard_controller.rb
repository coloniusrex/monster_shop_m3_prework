class Admin::DashboardController < Admin::BaseController
  def show

  end

  def user
    @user = User.find(params[:id])
  end

  def update
    order = Order.find (params[:id])
    order.status = "Shipped"
    order.save
    redirect_to '/admin'
  end

  def merchants
    @merchants = Merchant.all
  end
end
