Rails.application.routes.draw do
  
  require 'sidekiq/web'
  
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  get 'users/new'

  root             'static_pages#home'
  get   'help'    => 'static_pages#help'
  get   'about'   => 'static_pages#about'
  get   'contact' => 'static_pages#contact'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get     'quizzes'   => 'quiz#new'
  post    'quizzes'   => 'quiz#create'
  
  resources :users
  resources :coins,               only: [:index, :show]
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :transactions,        only: [:new,:create]
  
  mount Sidekiq::Web, at: '/sidekiq'
  
end
