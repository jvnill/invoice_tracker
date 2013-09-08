InvoiceTracker::Application.routes.draw do
  root to: 'sessions#new'

  get '/login' => 'sessions#new', as: :new_session
  post '/login' => 'sessions#create', as: :create_session
  delete '/logout' => 'sessions#destroy', as: :destroy_session

  resources :users
  resources :projects
  resources :clients

  resources :invoices do
    get :download, on: :member
  end
end
