Rails.application.routes.draw do
  default_url_options :host => "https://helping-others.herokuapp.com"
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :users
      resources :services
      resources :conversations, only: [:index, :create] do
        resources :messages, only: [:index, :create]
      end

      get '/latest', to: 'users#latest'
      get '/number-of-requests', to: 'tasks#numberOfRequests'
      
      post '/signup', to: 'authentication#signup'
      post '/login', to: 'authentication#login'
    end
  end
end
