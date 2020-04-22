Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    member do
      get :follow
      get :unfollow
      get :profile
    end  
  end  
end