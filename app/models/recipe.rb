class Recipe < ActiveRecord::Base
	has_many :meals, through: :meal_id
	has_many :ingredients, through: :ingred_id
	
end
