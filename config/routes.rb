Rails.application.routes.draw do
  resources :users do
    resources :posts do
      resources :comments, only: [:create, :new]
    end
  end
end
