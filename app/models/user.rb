class User < ApplicationRecord
	has_many :following
	has_many :followers 
	
  include Clearance::User
  include Clearance::User
end
