Rails.application.routes.draw do
  root to: 'gates#index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :gates do
    resource :like, only: [:create, :destroy]
  end

  namespace :admin do
    resources :gates
  end
end