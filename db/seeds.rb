# create a few users

User.destroy_all

user = User.new
user.username = "thomkel"
user.email = "thomkel@example.com"
user.password = "testpw"
user.password_confirmation = "testpw"
user.first_name = "Thomas"
user.last_name = "Kelly"
user.save

user = User.new
user.username = "graciegold"
user.email = "Gracie@example.com"
user.password = "heythere"
user.password_confirmation = "heythere"
user.first_name = "Gracie"
user.last_name = "Gold"
user.save

user = User.new
user.username = "eddyfitz"
user.email = "eddy@example.com"
user.password = "heythere1"
user.password_confirmation = "heythere1"
user.first_name = "Edmund"
user.last_name = "Fitzgerald"
user.save

user = User.new
user.username = "captnserious"
user.email = "toews@example.com"
user.password = "heythere2"
user.password_confirmation = "heythere2"
user.first_name = "Jonathan"
user.last_name = "Toews"
user.save

user = User.new
user.username = "dapkings"
user.email = "sharon@example.com"
user.password = "heythere9"
user.password_confirmation = "heythere9"
user.first_name = "Sharon"
user.last_name = "Jones"
user.save

user = User.new
user.username = "halford"
user.email = "halford@example.com"
user.password = "testpw"
user.password_confirmation = "testpw"
user.first_name = "Rob"
user.last_name = "Halford"
user.save

user = User.new
user.username = "marge"
user.email = "marge@example.com"
user.password = "testpw"
user.password_confirmation = "testpw"
user.first_name = "Marge"
user.last_name = "Kelly"
user.save

# create Follow relationships

Follow.destroy_all

gracie_id = marge_id = User.find_by(:username => "graciegold").id
marge_id = User.find_by(:username => "marge").id
halford_id = User.find_by(:username => "halford").id
toews_id = User.find_by(:username => "captnserious").id
thom_id = User.find_by(:username => "thomkel").id
sharon_id = User.find_by(:username => "dapkings").id

follow = Follow.new
follow.leader_id = gracie_id
follow.follower_id = marge_id
follow.save

follow = Follow.new
follow.leader_id = marge_id
follow.follower_id = gracie_id
follow.save

follow = Follow.new
follow.leader_id = halford_id
follow.follower_id = gracie_id
follow.save

follow = Follow.new
follow.leader_id = sharon_id
follow.follower_id = gracie_id
follow.save

follow = Follow.new
follow.leader_id = gracie_id
follow.follower_id = sharon_id
follow.save

follow = Follow.new
follow.leader_id = gracie_id
follow.follower_id = thom_id
follow.save

follow = Follow.new
follow.leader_id = thom_id
follow.follower_id = gracie_id
follow.save

follow = Follow.new
follow.leader_id = halford_id
follow.follower_id = thom_id
follow.save



# create FoodFeed entries

all_feed_data = [ { :title => "Baked Herb Pistachio Falafel",
                 :description => "12 sprigs of mint",
                 :url => "http://www.sproutedkitchen.com/home/2013/5/8/baked-herb-pistachio-falafel.html",
                 :image => "http://www.sproutedkitchen.com/storage/gks_falafel/GKS_FALAFEL_06.jpg",
                 :feed_type => "article",
                 :create_user_id => thom_id
                },
                { :title => "QUINOA CAULIFLOWER PATTIES",
                  :description => "1 cup quinoa",
                  :url => "http://www.sproutedkitchen.com/home/2013/9/26/quinoa-cauliflower-patties.html",
                  :image => "http://www.sproutedkitchen.com/storage/quinoa_cauliflower_patties/QUINOA_CAULIFLOWER_PATTIES_04.jpg",
                  :feed_type => "article",
                  :create_user_id => thom_id                
                },
                { :title => "How to chop an onion",
                  :description => "Gordon Ramsay demonstrates how to chop an onion... like a man",
                  :url => "//www.youtube.com/embed/TwGBt3V0yvc",
                  :image => nil,
                  :feed_type => "video",
                  :create_user_id => thom_id                
                },
                { :title => "Gene & Judes Hot Dog",
                  :description => "Genes & Judes > Superdawg",
                  :url => nil,
                  :image => "http://windycitysole.com/blog/wp-content/uploads/2012/02/image-2.jpeg",
                  :feed_type => "image",
                  :create_user_id => thom_id                
                }
            ]

FoodFeed.destroy_all
all_feed_data.each do |feed_info|
  f = FoodFeed.new
  f.title = feed_info[:title]
  f.description = feed_info[:description]
  f.url = feed_info[:url]
  f.image = feed_info[:image]
  f.feed_type = feed_info[:feed_type]
  f.create_user_id = feed_info[:create_user_id]
  f.save
end

# create Meals

all_meal_data = [ { :name => "Viet Hapa Phol",
                 :description => "Vietnamese Beef Noodle Soup",
                 :image => "http://img08.foodily.net/img/620x620/ff48f9f59395.jpg",
                 :user_id => thom_id
                },
                { :name => "Bahn Mi",
                  :description => "Vietnamese Sandwish",
                  :image => "http://img06.foodily.net/img/620x620/55d5bca750c7.jpg",
                  :user_id => gracie_id
                }
            ]



Meal.destroy_all
all_meal_data.each do |meal_info|
  f = Meal.new
  f.name = meal_info[:name]
  f.description = meal_info[:description]
  f.image = meal_info[:image]
  f.user_id = meal_info[:user_id]
  f.save
end

# create Ingredients

all_bahn_data = [ { :name => "carrot", :measure => "1 stick"},
                  { :name => "daikon", :measure => "2 tbps"},
                  { :name => "cider vinegar", :measure => "2 oz"},
                  { :name => "sugar", :measure => "2 cubes"},
                  { :name => "kosher salt", :measure => "3 tsp"},
                  { :name => "chili garlic salt", :measure => "2 tbsp"},
                  { :name => "pork tenderloin", :measure => "3 lbs"},
                  { :name => "mayonnaise", :measure => "1 cup"},
                  { :name => "cucumber", :measure => "1 whole"},
                  { :name => "cilantro", :measure => "2 bunches"},
                  { :name => "green onion", :measure => "1 bag"},
                  { :name => "jalapeno", :measure => "2 whole"}
                ]

all_pho_data = [{ :name => "yellow onion", :measure => "2 diced"},
                  { :name => "ginger", :measure => "1 minced"},
                  { :name => "beef bones", :measure => "4 whole"},
                  { :name => "oxtail", :measure => "2 lbs"},
                  { :name => "water", :measure => "1 gallon"},
                  { :name => "fish sauce", :measure => "1 cup"},
                  { :name => "bay leaves", :measure => "4 leaves"},
                  { :name => "cinnamon stick", :measure => "2 whole"},
                  { :name => "black peppercorn", :measure => "2 tsp"},
                  { :name => "star anise", :measure => "a pinch"},
                  { :name => "cloves, whole", :measure => "4"},
                  { :name => "rice sticks", :measure => "2"},
                  { :name => "beef tenderloin", :measure => "5 lbs"},
                  { :name => "bean sprout", :measure => ".5 lb"},
                  { :name => "lime", :measure => "3 whole, squeezed"},
                  { :name => "thai basil", :measure => "5 leaves"},
                ]

Ingredient.destroy_all
all_bahn_data.each do |ingred_info|
  f = Ingredient.new
  f.name = ingred_info[:name]
  f.save
end

all_pho_data.each do |ingred_info|
  f = Ingredient.new
  f.name = ingred_info[:name]
  f.save
end

# create Recipes

Recipe.destroy_all

phomeal = Meal.find_by(:name => "Viet Hapa Phol")
phomeal_id = phomeal.id

bahnmeal = Meal.find_by(:name => "Bahn Mi")
bahnmeal_id = bahnmeal.id

all_pho_data.each do |ingred_info|
  f = Recipe.new
  ingred = Ingredient.find_by(:name => ingred_info[:name])
  f.ingred_id = ingred.id
  f.meal_id = phomeal_id
  f.measure = ingred_info[:measure]
  f.save
end

all_bahn_data.each do |ingred_info|
  f = Recipe.new
  ingred = Ingredient.find_by(:name => ingred_info[:name])
  f.ingred_id = ingred.id
  f.meal_id = bahnmeal_id
  f.measure = ingred_info[:measure]
  f.save
end

# create Lists

List.destroy_all

list = List.new
list.name = "Pho List"
list.user_id = thom_id
list.save

list = List.new
list.name = "Bahn Mi List"
list.user_id = gracie_id
list.save

pholist = List.find_by(:name => "Pho List")
pho_id = pholist.id

bahnlist = List.find_by(:name => "Bahn Mi List")
bahn_id = bahnlist.id

#create List Items

# fill Pho List with pho list items

ListItem.destroy_all

all_pho_data.each do |ingred_info|
  f = ListItem.new
  ingred = Ingredient.find_by(:name => ingred_info[:name])
  f.ingredient_id = ingred.id
  f.list_id = pho_id
  f.save
end

# fill Bahn Mi List with bahn list items
all_bahn_data.each do |ingred_info|
  f = ListItem.new
  ingred = Ingredient.find_by(:name => ingred_info[:name])
  f.ingredient_id = ingred.id
  f.list_id = bahn_id
  f.save
end



