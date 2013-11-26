Rails.application.routes.draw do
  # Add your extension routes here
  namespace :admin do
    put '/orders/:id/pay_full_amount' => 'orders#pay_full_amount', :as => :pay_full_amount

    end
end
