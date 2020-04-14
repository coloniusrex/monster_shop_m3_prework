class ProfilesController < ApplicationController
  before_action :current_user_visitor?

  def show
  end

  private

  def current_user_visitor?
    render file: "public/404" if current_user.visitor?
  end

end
