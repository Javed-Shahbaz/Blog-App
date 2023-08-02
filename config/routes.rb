Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resoources :users, only: [:index, :show] do
    resoources :posts, only: [:index,:show]
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
