Nfr::Application.routes.draw do

  root to: 'home#index'

  #devise_for :users
  devise_for :users, controllers: { registrations: 'registrations' }

  resources :games, only: [:index, :show] do
    member do
      get :preview
      get :stat
      get :archive
    end
  end

  # resources :games, only: [:index, :show] do
  #   member do
  #     get :stat
  #     get :archive
  #   end

  #   get '/m' => 'mobile#index'

  #   resources :logs,    only: [:index] do
  #     collection do
  #       get :results
  #     end
  #   end

  #   resources :codes, only: [:index] do
  #     collection do
  #       put :attach
  #       put :bonus_action
  #       post :pass
  #     end
  #   end
  # end

  resources :teams

  resources :game_requests, only: [:create, :destroy]

  # resources :archives, only: [:index, :show] do
  #   member do
  #     get :short_stat
  #     get :wide_stat
  #   end
  # end

  resource :users
  # get '/users' => 'users#index',          as: :users
  # post '/users' => 'users#create',        as: :users
  # get '/users/new' => 'users#new',        as: :new_user
  # get '/users/:id/edit' => 'users#edit',  as: :edit_user
  get '/users/:id/team_requests' => 'users#team_requests',  as: :team_requests_user
  # get '/users/:id' => 'users#show',       as: :user
  # put '/users/:id' => 'users#update',     as: :user
  get '/users/:id/exclude' => 'users#exclude',     as: :exclude_user
  # delete '/users/:id' => 'users#destroy',    via: :delete, as: :user

  resources :team_requests, only: [] do
    member do
      put :accept
      put :reject
    end
  end

  namespace :admins do
    get '/action'     => 'common#action'
    get '/become/:id' => 'common#become', as: :become

    resources :sql, only: [:index, :create]
  end

  namespace :creators do
    resources :games
  end

  # resources :info, only: [] do
  #   collection do
  #     get :about
  #     get :contacts
  #   end
  # end

  # resources :mailouts, except: [:delete] do
  #   collection do
  #     put :send_mail
  #   end
  # end

  # # Games
  # # Game 10
  # get '/pic/yandex.jpg', to: redirect('http://klads.org.ua/nfr/010/pic/yandex.jpg')


  # Easters

  get '/blackjack', to: redirect('http://absolutist.ru/online/bjack/blackjack.swf')
  get '/hookers',   to: redirect('https://www.google.com.ua/search?site=imghp&tbm=isch&q=%D1%88%D0%BB%D1%8E%D1%85%D0%B8')
  get '/filler' => 'easters#filler'
  get '/miner' =>  'easters#miner'

end
