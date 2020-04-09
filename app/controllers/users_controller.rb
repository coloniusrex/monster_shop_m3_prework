class UsersController < ApplicationController
  def password
  end

  def update_password
    user = User.find(current_user.id)
    if params[:password] == params[:confirmation]
      user.password = params[:password]
      if params[:password] == ''
        flash[:error] = 'Your password or confirm password is blank.'
        render :password
      elsif user.save
        flash[:notice] = 'Your password has been updated.'
        redirect_to '/profile'
      else
        flash[:notice] = 'Your password did not save correctly'
        render :password
      end
    else
      flash[:error] = 'Your password and confirm password do not match.'
      render :password
    end
  end
end
