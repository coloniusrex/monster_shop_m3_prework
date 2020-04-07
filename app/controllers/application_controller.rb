class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :cart, :current_user

  def cart
    @cart ||= Cart.new(session[:cart] ||= Hash.new(0))
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = User.new
    end
  end

  def current_merchant?
    current_user && (current_user.role == 2)
  end

  def current_admin?
    current_user && (current_user.role == 3)
  end

end
