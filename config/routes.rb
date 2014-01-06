Nfr::Application.routes.draw do

  root :to => 'home#index'

  #devise_for :users
  devise_for :users, controllers: { registrations: 'registrations' }

  resources :games, only: [:index, :show] do
    member do
      get :stat
      get :archive
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

  resources :archives, only: [:index, :show] do
    member do
      get :short_stat
      get :wide_stat
    end
  end

# resource :users
  match '/users' => 'users#index',          via: :get,    as: :users
  match '/users' => 'users#create',         via: :post,   as: :users
  match '/users/new' => 'users#new',        via: :get,    as: :new_user
  match '/users/:id/edit' => 'users#edit',  via: :get,    as: :edit_user
  match '/users/:id/team_requests' => 'users#team_requests',  via: :get, as: :team_requests_user
  match '/users/:id' => 'users#show',       via: :get,    as: :user
  match '/users/:id' => 'users#update',     via: :put,    as: :user
  match '/users/:id/exclude' => 'users#exclude',     via: :get,    as: :exclude_user
  match '/users/:id' => 'users#destroy',    via: :delete, as: :user

  resources :team_requests, only: [] do
    member do
      put :accept
      put :reject
    end
  end

  namespace :admins do
    match '/action'     => 'common#action'
    match '/become/:id' => 'common#become', as: :become

    resources :sql, only: [:index, :create]
  end

  namespace :creators do
    resources :games
  end

  resources :info, only: [] do
    collection do
      get :about
      get :contacts
    end
  end

  resources :mailouts, except: [:delete] do
    collection do
      put :send_mail
    end
  end

  # Easters

  get '/blackjack', to: redirect('http://absolutist.ru/online/bjack/blackjack.swf')
  get '/hookers',   to: redirect('https://www.google.com.ua/search?site=imghp&tbm=isch&q=%D1%88%D0%BB%D1%8E%D1%85%D0%B8')
  match '/filler' => 'easters#filler'

end
