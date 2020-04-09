class ProfilesController < ApplicationController
  before_action :require_user

  def show
  end

  def edit
  end

  def update
    if !existing_email?
      if current_user.update!(user_params)
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
    params.permit(:name, :address, :city, :state, :zip, :email)
  end

  def require_user
    render file: "public/404" unless current_user.role > 0
  end

end
