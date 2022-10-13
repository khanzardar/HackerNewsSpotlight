Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "stories#index"
  get "/stories", to: "stories#index"
  get "/stories/:id", to: "stories#show"
end
