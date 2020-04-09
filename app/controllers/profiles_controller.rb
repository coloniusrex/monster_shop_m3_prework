class ProfilesController < ApplicationController
  before_action :require_user

  def show
  end

  private

  def require_user
    render file: "public/404" unless current_user.role > 0
  end

end
