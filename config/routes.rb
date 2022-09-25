# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'products#index'

  resources :orders, only: %i[index show]

  resources :products, only: :show do
    resources :orders, only: [:create], shallow: true do
      member do
        post '/liqpay_payment' => 'payments#liqpay_payment'
      end
    end
  end
end
