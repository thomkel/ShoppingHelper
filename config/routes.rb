ShoppingHelper::Application.routes.draw do
  resources :list_items

  resources :lists
  resources :meals
  resources :food_feeds
  resources :users
  resources :sessions

  # clean up redundant routes

  root "food_feeds#index"

  get "/foodfeed" => "food_feeds#index"

  get "/meals" => "meals#index"
  get "/meals/:id/add" => "meals#add_ingreds"
  post "meals/:id/add" => "meals#save_new_ingreds"

  # get "/lists" => "food_feeds#index" # need to change

  get "/endsession" => "sessions#destroy"

  get "/findusers" => "users#findusers"

  post "/follow" => "users#follow"

  get "/recipes/:id" => "meals#edit_ingreds"
  patch "recipes/:id" => "meals#update_recipe"

  delete "/users/follows/:id" => "users#delete_follows"

  get "/addmeals/:id" => "lists#add_meals"
  post "/addmeals/:id" => "lists#add_meal_to_list"
  
end
