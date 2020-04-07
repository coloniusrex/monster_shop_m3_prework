class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = 'You have successfully logged in.'
      if user.role == 1
        redirect_to '/profile'
      elsif user.role == 2
        redirect_to '/merchant/dashboard'
      elsif user.role == 3
        redirect_to '/admin/dashboard'
      end
    else
      flash[:notice] = "Your credentials are incorrect."
      render :new
    end
  end
end
