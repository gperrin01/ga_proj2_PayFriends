Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
 
# start by assuming user is Gui
   root 'users#index'

   get 'logout', to: 'sessions#destroy', as: 'logout'

   post '/users/login', to: 'users#login'
   # get '/users/login', to: 'deals#index'
   
   resources :deals

   # UPDATE WITH CREAET_USERS since Devise is using my create user method!!!!!!
   post '/users/create_friend', to: 'users#create_friend'

   resources :users

   resources :sessions


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
