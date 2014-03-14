class Ingredient < ActiveRecord::Base

	has_many :recipes, foreign_key: :ingred_id
	has_many :list_items
end
