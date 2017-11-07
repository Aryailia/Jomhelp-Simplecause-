class ContributorsController < ApplicationController
	enum role: [ :volunteer, :super_volunteer, :manager, :admin ]
	belongs_to :organisation
	belongs_to :user
end
