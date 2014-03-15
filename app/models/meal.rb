class Meal < ActiveRecord::Base

	belongs_to :user
	has_many :ingredients, through: :recipes, foreign_key: :ingred_id
	has_many :recipes, dependent: :destroy
end
