class Organisation < ApplicationRecord
	has_many :users, through: :contributors
	has_many :contributors
end
