CityRails::Application.routes.draw do
  root to: "users#show"

  match 'users/:id/all_friends', to: 'users#all_friends', as: 'user_all_friends'
  match 'users/:id/friends_by_city', to: 'users#friends_by_city', as: 'user_friends_by_city'
  match 'users/:id/venues', to: 'users#venues', as: 'venues'
  match 'users/:id/friends_in_my_city', to: 'users#friends_in_my_city', as: 'user_friends_in_my_city'
  match 'users/:id/friends_in_city/:city_id', to: "users#friends_in_city", as: 'user_friends_in_city'
  match 'users/:id/create_contacts', to: 'users#create_contacts', as: 'user_create_contacts'
  match 'reset_password', to: 'users#reset_password', as: 'reset_password'

  resources :cities

  resources :venues
  
  resources :users, :except => [:edit, :index]

  resources :invitations, :only => [:create]

  resources :device_tokens, :only => [:create]

end
