ShoppingHelper::Application.routes.draw do
  resources :list_items

  resources :lists
  resources :meals
  resources :food_feeds
  resources :users
  resources :sessions

  root "food_feeds#index"

  get "/foodfeed" => "food_feeds#index"

  get "/meals" => "meals#index"

  # get "/lists" => "food_feeds#index" # need to change

  get "/endsession" => "sessions#destroy"

  get "/findusers" => "users#findusers"

  post "/follow" => "users#follow"

  get "/ingreds/:id" => "meals#edit_ingreds"
  
end
