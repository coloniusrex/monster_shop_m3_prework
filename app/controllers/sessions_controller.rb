class SessionsController < ApplicationController
  def new

    if current_user.role == 1
      flash[:notice] = "You're already logged in."
      redirect_to '/profile'
    elsif current_user.role == 2
      flash[:notice] = "You're already logged in."
      redirect_to '/merchant/dashboard'
    elsif current_user.role == 3
      flash[:notice] = "You're already logged in."
      redirect_to '/admin/dashboard'
    end

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

  def logout
    binding.pry
  end

end
