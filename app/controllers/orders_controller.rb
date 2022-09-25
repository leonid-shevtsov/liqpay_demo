# frozen_string_literal: true

# Handles orders rendering and creation
class OrdersController < ApplicationController
  def index
    @orders = Order.latest
  end

  def show
    @order = Order.find(params[:id])

    return unless @order.status == 'new'

    @liqpay_request = Liqpay::Request.new(
      amount: @order.product.price,
      currency: 'UAH',
      description: @order.product.title,
      order_id: @order.id,
      result_url: order_url(@order),
      server_url: liqpay_payment_order_url(@order)
    )
  end

  def create
    @order = Order.new(params.require(:order).permit(:product_id))

    if @order.save
      redirect_to @order
    else
      redirect_to root_path
    end
  end
end
