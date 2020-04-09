class ProfilesController < ApplicationController
  before_action :require_user

  def show
  end

  def edit
  end

  def update
    user = User.find(current_user.id)
    if !existing_email?
      if user.update!(user_params)
        flash[:notice] = "Your information has successfully been updated."
        redirect_to "/profile"
      end
    else
      flash[:error] = "That email is already in use."
      render :edit
    end
  end

  private

  def existing_email?
    User.exists?(email: params[:email]) && params[:email] != current_user.email
  end

  def user_params
    params[:password_digest] = current_user.password_digest
    params.permit(:name, :address, :city, :state, :zip, :email, :password_digest)
  end

  def require_user
    render file: "public/404" unless current_user.role > 0
  end

end
