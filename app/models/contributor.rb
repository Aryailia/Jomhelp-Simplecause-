class Contributor < ApplicationRecord
	enum role: [ :member, :manager, :admin ]
	belongs_to :organisation
	belongs_to :user

end
