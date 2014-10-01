InvoiceTracker::Application.routes.draw do
  root to: 'sessions#new'

  get '/login' => 'sessions#new', as: :new_session
  post '/login' => 'sessions#create', as: :create_session
  delete '/logout' => 'sessions#destroy', as: :destroy_session

  resources :users, only: %i[new create edit update]
  resources :projects
  resources :clients
  resources :passwords, only: %i[new create edit update]

  resources :invoices do
    member do
      get :download
      patch :cycle_status
    end
  end
end
