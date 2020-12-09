Rails.application.routes.draw do
  resources :transactions do
    collection do
      post 'upload'
    end
  end
  resources :transaction_types, path: 'transaction-types'
  resources :customers
  resources :stores

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
