class Organisation < ApplicationRecord
	has_many :contributors
	has_many :events
	has_many :follows
	has_many :users, through: :follows
end
