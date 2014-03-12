class ListItem < ActiveRecord::Base

	has_many :ingredients, through: :ingred_id
	has_many :lists, through: :list_id
	
end
