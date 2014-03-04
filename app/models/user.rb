class User < ActiveRecord::Base

	validates :first_name, :presence=>true
	validates :last_name, :presence=>true
	validates :username, :presence=>true, :uniqueness=>true, length: 5..12
	validates :email, :presence=>true, :uniqueness=>true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create }
  # I run this validation on :create so that user 
  # can edit login_name without having to enter password      
  	validates :password,:presence=>true, length: 5..12,:on=>:create

  # this should only run if the password has changed
  	validates :password_confirmation, 
            :presence=>true, :if => :password_digest_changed?

 	has_secure_password

end
