class List < ActiveRecord::Base

	has_one :users
	has_many :list_items
end
