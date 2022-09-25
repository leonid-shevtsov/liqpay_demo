# frozen_string_literal: true

Liqpay.default_options = {
  public_key: ENV.fetch('LIQPAY_PUBLIC_KEY', nil),
  private_key: ENV.fetch('LIQPAY_PRIVATE_KEY', nil)
}
