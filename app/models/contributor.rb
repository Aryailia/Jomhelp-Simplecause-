class Contributor < ApplicationRecord
	enum role: [ :member, :manager, :admin ]
	belongs_to :organisation
	belongs_to :user
	validates :user_id, uniqueness: { scope: :organisation_id }

end
