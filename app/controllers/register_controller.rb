class RegisterController < ApplicationController

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Your account has been created."
      redirect_to "/profile"
    else
      flash[:error] = "Unable to create account: Required information missing."
      render :new
    end
  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password, :confirm_pass)
  end
end
