InvoiceTracker::Application.routes.draw do
  root to: 'pages#landing'

  get '/login' => 'sessions#new', as: :new_session
  post '/login' => 'sessions#create', as: :create_session
  delete '/logout' => 'sessions#destroy', as: :destroy_session

  resources :users
  resources :projects
  resources :clients

  resources :invoices do
    get :download, on: :member
  end

  %w[tour pricing about].each do |path|
    get "/#{path}" => "pages##{path}", as: path
  end
end
