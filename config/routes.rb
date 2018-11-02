Rails.application.routes.draw do
  get 'registration/new', to: 'registration#new'
  post 'registration/new', to: 'registration#sign_in'
  put 'registration/new', to: 'registration#log_out'
  post 'likes', to: 'likes#create'
  delete 'likes', to: 'likes#delete'
  root 'gossips#home'
  resources :gossips
  resources :comments
end
