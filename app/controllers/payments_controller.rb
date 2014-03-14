class PaymentsController < ApplicationController
  protect_from_forgery :except => :liqpay_payment

  def liqpay_payment
    @liqpay_response = Liqpay::Response.new(params)
    @order = Order.find(@liqpay_response.order_id)
    
    @order.data = {}

    (Liqpay::Response::ATTRIBUTES - %w(public_key sender_phone transaction_id)).each do |attribute|
      @order.data[attribute] = @liqpay_response.send(attribute)
    end

    if @liqpay_response.success?
      @order.update_attributes!(:status => 'success')
    else
      @order.update_attributes!(:status => 'failed')
    end
    redirect_to @order
  rescue Liqpay::InvalidResponse
    render text: 'Payment error', status: 500
  end
end
