class OrdersController < ApplicationController
  def index
    @orders = Order.latest
  end

  def show
    @order = Order.find(params[:id])

    if @order.status == 'new'
      @liqpay_request = Liqpay::Request.new(
        :amount => @order.product.price,
        :currency => 'UAH',
        :description => @order.product.title,
        :order_id => @order.id,
        :result_url => liqpay_payment_order_url(@order) 
      )
    end
  end

  def create
    @order = Order.new(params[:order])

    if @order.save
      redirect_to @order
    else
      redirect_to root_path
    end
  end
end
