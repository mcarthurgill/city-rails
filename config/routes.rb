CityRails::Application.routes.draw do
  root to: "cities#index"

  match 'users/:id/all_friends', to: 'users#all_friends', as: 'user_all_friends'
  match 'users/:id/friends_by_city', to: 'users#friends_by_city', as: 'user_friends_by_city'
  match 'users/:id/venues', to: 'users#venues', as: 'venues'
  match 'users/:id/friends_in_my_city', to: 'users#friends_in_my_city', as: 'user_friends_in_my_city'
  match 'users/:id/friends_in_city/:city_id', to: "users#friends_in_city", as: 'user_friends_in_city'
  match 'users/:id/create_contacts', to: 'users#create_contacts', as: 'user_create_contacts'
  match 'reset_password', to: 'users#reset_password', as: 'reset_password'
  match 'users/:id/friend_favorites_for_city/:city_id', to: 'users#friend_favorites_for_city', as: 'friend_favorites'

  resources :cities

  resources :venues
  
  resources :users, :except => [:edit, :index]

  resources :invitations, :only => [:create]

  resources :device_tokens, :only => [:create]

  match "privacy_policy", to: "users#privacy_policy", as: "privacy_policy"

end
