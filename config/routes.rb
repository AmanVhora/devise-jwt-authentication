Rails.application.routes.draw do
  resources :posts
  get 'users', to: 'current_user#index'
  get 'current_user', to: 'current_user#show'
  
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
end
