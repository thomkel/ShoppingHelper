class Follow < ActiveRecord::Base
	# one user as leader, one user as follower

	has_many :users

end
