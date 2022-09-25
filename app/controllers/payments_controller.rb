# frozen_string_literal: true

# Handles server-to-server Liqpay payment result callback
class PaymentsController < ApplicationController
  protect_from_forgery except: :liqpay_payment

  def liqpay_payment
    @liqpay_response = Liqpay::Response.new(params.permit(:data, :signature))
    @order = order_from_response!(@liqpay_response)
    redirect_to @order
  rescue Liqpay::InvalidResponse
    render text: 'Payment error', status: :internal_server_error
  end

  private

  def order_from_response!(liqpay_response)
    order = Order.find(liqpay_response.order_id)

    order.data = {}

    (Liqpay::Response::ATTRIBUTES - %w[public_key sender_phone transaction_id]).each do |attribute|
      order.data[attribute] = liqpay_response.send(attribute)
    end

    if liqpay_response.success?
      order.update!(status: 'success')
    else
      order.update!(status: 'failed')
    end
  end
end
