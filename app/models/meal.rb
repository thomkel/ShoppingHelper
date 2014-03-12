class Meal < ActiveRecord::Base

	has_one :users
	has_many :ingredients
	has_many :recipes
end
