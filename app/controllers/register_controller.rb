class RegisterController < ApplicationController

  def new
  end

  def create
    @user = User.new(user_params)
    @user.role = 1

    if User.exists?(email: user_params[:email])
      flash[:error] = "Email already in use. Try a different email."
      render :new
    elsif params[:confirm_pass] != params[:password]
      flash[:error] = "Passwords don't match."
      render :new
    elsif params[:confirm_pass] == params[:password] && @user.save
      session[:user_id] = @user.id
      flash[:success] = "Your account has been created."
      redirect_to "/profile"
    else
      flash[:error] = "Unable to create account: Required information missing."
      render :new
    end
  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password)
  end
end
