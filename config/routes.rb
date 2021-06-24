Rails.application.routes.draw do
  resources :transactions
  namespace :dashboard_user do
    get 'home/index'
  end
  devise_for :users

  root :to => "dashboard_user/home#index"
end
