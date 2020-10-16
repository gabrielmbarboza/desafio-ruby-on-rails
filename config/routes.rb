Rails.application.routes.draw do
  resources :transactions
  resources :transaction_types
  resources :customers
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :stores
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
