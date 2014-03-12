class Follow < ActiveRecord::Base
	# one user as leader, one user as follower

	has_many :users, through: :leader_id
	has_many :users, through: :follower_id

end
