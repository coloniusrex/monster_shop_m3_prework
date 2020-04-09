class UsersController < ApplicationController

  def edit
  end

  def update
    if !existing_email?
      if current_user.update(user_params)
        flash[:notice] = "Your information has successfully been updated."
        redirect_to "/profile"
      end
    else
      flash[:error] = "That email is already in use."
      render :edit
    end
  end

  def password
  end

  def update_password
    user = User.find(current_user.id)
    if params[:password] == params[:confirmation]
      user.password = params[:password]
      if params[:password] == ''
        flash[:error] = 'Your password is blank.'
        render :password
      elsif user.save
        flash[:notice] = 'Your password has been updated.'
        redirect_to '/profile'
      end
    else
      flash[:error] = 'Your password and confirm password do not match.'
      render :password
    end
  end

  private

  def existing_email?
    User.exists?(email: params[:email]) && params[:email] != current_user.email
  end

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email)
  end

end
