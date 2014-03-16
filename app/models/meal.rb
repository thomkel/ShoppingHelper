class Meal < ActiveRecord::Base

	validates :name, :presence => true

	belongs_to :user
	has_many :ingredients, through: :recipes, foreign_key: :ingred_id
	has_many :recipes, dependent: :destroy
end
