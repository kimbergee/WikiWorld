Rails.application.routes.draw do

  root 'welcome#index'

  get 'users/index'
  get 'users/show'
  get 'welcome/index'
  get 'welcome/about'

  devise_for :users

  resources :users

end
