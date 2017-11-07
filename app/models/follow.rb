class Follow < ApplicationRecord

	belongs_to :followers
	belongs_to :following 

end 