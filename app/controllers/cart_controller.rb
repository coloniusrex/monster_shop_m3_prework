class CartController < ApplicationController
  before_action :check_role

  def add_item
    item = Item.find(params[:item_id])
    cart.add_item(item.id.to_s)
    flash[:success] = "#{item.name} was successfully added to your cart"
    redirect_to "/items"
  end

  def show
    @items = cart.items
  end

  def empty
    session.delete(:cart)
    redirect_to '/cart'
  end

  def remove_item(item = nil)
    item.nil? ? (session[:cart].delete(params[:item_id])) : session[:cart].delete(item)
    redirect_to '/cart'
  end

  def update
    if params[:quantity] == "inc"
      cart.add_quantity(params[:id]) unless cart.limit_reached?(params[:id])
    elsif params[:quantity] == "dec"
      cart.subtract_quantity(params[:id])
      return remove_item(params[:id]) if cart.quantity_zero?(params[:id])
    end
    redirect_to "/cart"
  end

  private

  def check_role
    render file: "/public/404" unless current_user.role < 3
  end
end
