class ListItem < ActiveRecord::Base

	has_many :ingredients
	belongs_to :list
end
