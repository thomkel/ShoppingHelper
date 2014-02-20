ShoppingHelper::Application.routes.draw do
  resources :meals

  resources :food_feeds

  root "food_feeds#index"

  get "/foodfeed" => "food_feeds#index"

  get "/meals" => "meals#index"

  get "/lists" => "food_feeds#index" # need to change
  
end
