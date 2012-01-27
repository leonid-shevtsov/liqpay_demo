LiqpayDemo::Application.routes.draw do
  root :to => 'products#index'

  resources :products, :only => :show do 
    resources :orders, :only => [:show, :create], :shallow => true do
      member do
        post '/liqpay_payment' => 'payments#liqpay_payment'
      end
    end
  end
end
