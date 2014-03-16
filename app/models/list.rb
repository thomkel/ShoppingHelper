class List < ActiveRecord::Base

	validates :name, :presence => true	

	belongs_to :user
	has_many :list_items, dependent: :destroy
end
