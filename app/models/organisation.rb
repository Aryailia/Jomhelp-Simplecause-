class Organisation < ApplicationRecord

	has_many  :users, through: :contributors
	has_many  :contributors
	has_many  :events
	has_many  :follows
	has_many  :users, through: :follows
	validates :email, uniqueness: true
	mount_uploader :photos, PhotoUploader
	has_many  :posts
end

