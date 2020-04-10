class Admin::DashboardController < Admin::BaseController
  def show

  end

  def user
    @user = User.find(params[:id])
  end
end
