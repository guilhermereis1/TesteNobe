Rails.application.routes.draw do
  namespace :dashboard_user do
    get 'extract/index'
  end
  resources :transactions
  namespace :dashboard_user do
    get 'home/index'
  end
  devise_for :users

  root :to => "dashboard_user/home#index"
end
