 class ApplicationController < ActionController::Base
  include Clearance::Controller
  include ApplicationHelper
  include ContributorsHelper
  
  protect_from_forgery with: :exception

  class ErrorWithRedirect < StandardError
    attr_accessor :path
  
    def initialize(message = nil, path = nil)
      super(message)
      self.path = path
    end
  end  
end
