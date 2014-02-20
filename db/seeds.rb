# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

all_feed_data = [ { :title => "Baked Herb Pistachio Falafel",
                 :description => "12 sprigs of mint",
                 :url => "http://www.sproutedkitchen.com/home/2013/5/8/baked-herb-pistachio-falafel.html",
                 :image => "http://www.sproutedkitchen.com/storage/gks_falafel/GKS_FALAFEL_06.jpg"
                },
                { :title => "QUINOA CAULIFLOWER PATTIES",
                  :description => "1 cup quinoa",
                  :url => "http://www.sproutedkitchen.com/home/2013/9/26/quinoa-cauliflower-patties.html",
                  :image => "http://www.sproutedkitchen.com/storage/quinoa_cauliflower_patties/QUINOA_CAULIFLOWER_PATTIES_04.jpg"
                }
            ]

FoodFeed.destroy_all
all_feed_data.each do |feed_info|
  f = FoodFeed.new
  f.title = feed_info[:title]
  f.description = feed_info[:description]
  f.url = feed_info[:url]
  f.image = feed_info[:image]
  f.save
end

all_meal_data = [ { :name => "Viet Hapa Phol",
                 :description => "Vietnamese Beef Noodle Soup",
                 :image => "http://img08.foodily.net/img/620x620/ff48f9f59395.jpg"
                },
                { :name => "Bahn Mi",
                  :description => "Vietnamese Sandwish",
                  :image => "http://img06.foodily.net/img/620x620/55d5bca750c7.jpg"
                }
            ]

Meal.destroy_all
all_meal_data.each do |meal_info|
  f = Meal.new
  f.name = meal_info[:name]
  f.description = meal_info[:description]
  f.image = meal_info[:image]
  f.save
end

all_bahn_data = [ { :name => "carrot"},
                  { :name => "daikon"},
                  { :name => "cider vinegar"},
                  { :name => "sugar"},
                  { :name => "kosher salt"},
                  { :name => "chili garlic salt"},
                  { :name => "pork tenderloin"},
                  { :name => "mayonnaise"},
                  { :name => "cucumber"},
                  { :name => "cilantro"},
                  { :name => "green onion"},
                  { :name => "jalapeno"}
                ]

all_pho_data = [{ :name => "yellow onion"},
                  { :name => "ginger"},
                  { :name => "beef bones"},
                  { :name => "oxtail"},
                  { :name => "water"},
                  { :name => "fish sauce"},
                  { :name => "bay leaves"},
                  { :name => "cinnamon stick"},
                  { :name => "black peppercorn"},
                  { :name => "star anise"},
                  { :name => "cloves, whole"},
                  { :name => "rice sticks"},
                  { :name => "beef tenderloin"},
                  { :name => "bean sprout"},
                  { :name => "lime"},
                  { :name => "thai basil"},
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
