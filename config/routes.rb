Rails.application.routes.draw do
  root to: 'gates#index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :gates do
    collection do
      get :search_tag
      get :manage
      get :join_server
    end
    resource :like, only: [:create, :destroy]
  end

  
  namespace :admin do
    resources :gates
    resources :users
    root action: 'dashboard'
    get :manage_gates
    get :manage_users
    delete :destroy_mutiple
    delete :destroy_mutiple_user
  end
end
