Rails.application.routes.draw do
  resources :transactions

  namespace :dashboard_user do
    post 'make_transfer/:user_id' => 'transfer#make_transfer', as: 'make_transfer'
    get 'extract/index'
    get 'transfer/index'
    get 'home/index'
  end
  devise_for :users

  root :to => "dashboard_user/home#index"
end
