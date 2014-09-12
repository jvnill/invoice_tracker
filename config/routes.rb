InvoiceTracker::Application.routes.draw do
  root to: 'sessions#new'

  get '/login' => 'sessions#new', as: :new_session
  post '/login' => 'sessions#create', as: :create_session
  delete '/logout' => 'sessions#destroy', as: :destroy_session

  resources :users, only: %i[new create edit update]
  resources :projects
  resources :clients

  resources :invoices do
    member do
      get :download
      patch :mark_as_sent
      patch :mark_as_paid
    end
  end
end
