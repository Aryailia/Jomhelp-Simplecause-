 class ApplicationController < ActionController::Base
  include Clearance::Controller
  include ContributorsHelper
  
  protect_from_forgery with: :exception
end
