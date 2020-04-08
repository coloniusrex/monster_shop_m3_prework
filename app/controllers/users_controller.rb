class UsersController < ApplicationController
  def password
  end

  def update_password
    user = User.find(current_user.id)
    user.password = params[:password]
    if user.save
      flash[:notice] = 'Your password has been updated.'
      redirect_to '/profile'
    else
      flash[:error] = 'Something went wrong'
    end

  end
end
