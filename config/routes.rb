Rails.application.routes.draw do
  root 'tickets#new'

  get 'pictures/index'

  get 'pictures/new'

  get 'pictures/create'

  get 'pictures/update'

  devise_for :staffs

  resource :staff, only: [:edit, :new] do
    collection do
      patch 'update_password'
      patch 'create_member'
      get 'list'
    end
  end 

  concern :postable do
    resources :posts
  end

  resources :staffs, concerns: :postable
  resources :users, concerns: :postable

  resources :tickets, only: [:index, :new, :create]
  resources :pictures

  
  match 'tickets/suggestions' => 'tickets#suggestions', :via => :get, :as => 'ticket_suggestion'
  match 'tickets/search_form' => 'tickets#search_form', :via => :get, :as => 'ticket_search_form'
  match 'tickets/search' => 'tickets#search', :via => :post, :as => 'ticket_search'
  match 'tickets/broadcast' => 'tickets#broadcast', :via => :get, :as => 'ticket_broadcast'
  match 'tickets/:token' => 'tickets#show', :via => :get, :as => 'ticket_show'
  match 'tickets/:token' => 'tickets#update', :via => :put, :as => 'ticket'
  match 'tickets/:token/edit' => 'tickets#edit', :via => :get, :as => 'ticket_edit'
  

  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
