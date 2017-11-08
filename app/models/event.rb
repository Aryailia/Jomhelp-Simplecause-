class Event < ApplicationRecord
  belongs_to :organisation
	has_many :events, through: :attendees
end
