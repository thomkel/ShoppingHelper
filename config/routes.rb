ShoppingHelper::Application.routes.draw do
  resources :list_items
  resources :lists
  resources :meals
  resources :food_feeds
  resources :users
  resources :sessions

  root "food_feeds#index"

  get "/meals/:id/add" => "meals#add_ingreds"
  post "/meals/:id/add" => "meals#save_new_ingreds"

  get "/endsession" => "sessions#destroy"

  get "/findusers" => "users#findusers"

  post "/follow" => "users#follow"

  get "/recipes/:id" => "meals#edit_ingreds"
  patch "/recipes/update/:id" => "meals#update_recipe"
  delete "/recipes/update/:id" => "meals#delete_recipe"

  delete "/users/follows/:id" => "users#delete_follows"

  get "/addmeals/:id" => "lists#add_meals"
  post "/addmeals/:id" => "lists#add_meal_to_list"

  post "/lists/:id" => "lists#show"
  get "/addingreds/lists/:id" => "lists#add_ingreds"
  post "/add/lists/:id" => "lists#add_ingreds_to_list"
end
