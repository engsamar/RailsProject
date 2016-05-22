Rails.application.routes.draw do
  resources :invitations
  resources :group_members
<<<<<<< HEAD
  # devise_for :users , :controllers => { registrations: 'registrations' }
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" , registrations: 'registrations'}

  resources :friends
=======
  devise_for :users , :controllers => { registrations: 'registrations' }
  # resources :friends
>>>>>>> 481ab624cf31a45f8c95dc106c2f3ad54f5eeebd
  resources :orderdetails
  resources :orders
  resources :groups

  resources :orders do 
    resources :orderdetails
  end
resources :orders do 
    resources :invitations
  end

  post 'orders/:id' => 'orders#finish'

  # resources :users
<<<<<<< HEAD
  # resource :users do
  #   get "search"
  # end
=======
  resource :users do
    get "search"
    end
  resources :friends do 
      get "unfriend"
    end
>>>>>>> 481ab624cf31a45f8c95dc106c2f3ad54f5eeebd
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  get '/check', to: 'home#check'
  get 'welcome/check', to: 'welcome#check'
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
