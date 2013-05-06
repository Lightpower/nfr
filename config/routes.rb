Nfr::Application.routes.draw do

  devise_for :users

  root :to => 'home#index'

  resources :games, only: [:index, :show] do
    member do
      get :stat
    end

    match '/m' => 'mobile#index'

    resources :logs,    only: [:index] do
      collection do
        get :results
      end
    end

    resources :codes, only: [:index] do
      collection do
        put :attach
        put :bonus_action
        post :pass
      end
    end
  end

  resources :teams

  resources :game_requests, only: [:create, :destroy]

# resource :users
  match "/users" => "users#index",          via: :get,    as: :users
  match "/users" => "users#create",         via: :post,   as: :users
  match "/users/new" => "users#new",        via: :get,    as: :new_user
  match "/users/:id/edit" => "users#edit",  via: :get,    as: :edit_user
  match "/users/:id/team_requests" => "users#team_requests",  via: :get, as: :team_requests_user
  match "/users/:id" => "users#show",       via: :get,    as: :user
  match "/users/:id" => "users#update",     via: :put,    as: :user
  match "/users/:id" => "users#destroy",    via: :delete, as: :user
  #match "/users/:id/approve_team_request" => "users#approve_team_request",  via: :get, as: :approve
  #match "/users/:id/reject_team_request" => "users#reject_team_request",    via: :get, as: :reject

  resources :team_requests, only: [] do
    member do
      put :accept
      put :reject
    end
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.





  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
