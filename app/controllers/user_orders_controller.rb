class UserOrdersController < ApplicationController
  def index

  end

  def show
    @order = Order.find(params[:id])
  end
end
