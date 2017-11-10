class Event < ApplicationRecord
  belongs_to(:organisation)
	has_many(:attendees); has_many(:users, through: :attendees)

  mount_uploaders :photos, PhotoUploader
end
