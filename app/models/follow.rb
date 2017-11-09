class Follow < ApplicationRecord
	belongs_to :organisation
	belongs_to :user
	
  validates_uniqueness_of :user_id, :scope => [:organisation_id]
end 