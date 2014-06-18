Rails.application.routes.draw do
  get 'histories/index'

  root 'tickets#new'

  devise_for :staffs

  resource :staff, only: [:edit, :new] do
    collection do
      patch :update_password
      patch :create_member
    end
  end 

  resources :staffs do
    resource :tickets
  end

  resources :tickets do
    member do
      get :take
    end

    collection do
      get :suggestions
      get :search_form
      post :search
      get :broadcast 
      get '/token/:token', action: :show, as: :show
      put '/token/:token/update', action: :update, as: :update
      get '/token/:token/edit', action: :edit, as: :edit
      put '/:token/change_status', action: :change_status, as: :change_status
    end
    resources :posts     
  end

  resources :pictures, only: [:destroy]
  resources :histories, only: [:index]
end