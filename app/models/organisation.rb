class Organisation < ApplicationRecord

	has_many  :users, through: :contributors
	has_many  :contributors
	has_many  :events
	has_many  :follows
	has_many  :users, through: :follows
	
	mount_uploader :photos, PhotoUploader
	has_many  :posts

	validates :name, presence: true
	validates :address, presence: true
	validates :postcode, presence: true
	validates :description, presence: true

end

