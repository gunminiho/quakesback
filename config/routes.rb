Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/api/features', to: 'earthquakes#index', as: 'earthquakes'
  post '/api/features/:feature_id/comments', to: 'comments#create', as: 'comments'


end
