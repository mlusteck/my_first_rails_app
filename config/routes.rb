Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :products
  resources :orders, only: [:index, :show, :create, :destroy]
  get 'simple_pages/about'
  get 'simple_pages/contact'
  get 'simple_pages/index'
  post 'simple_pages/thank_you'
  root 'simple_pages#landing_page'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
