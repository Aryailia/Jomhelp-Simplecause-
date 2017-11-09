 class ApplicationController < ActionController::Base
  include Clearance::Controller
  include ContributorsHelper
  
  protect_from_forgery with: :exception

  class ErrorWithRedirect < StandardError
    attr_accessor :path
  
    def initialize(message = nil, path = nil)
      super(message)
      self.path = path
    end

    def self.defaultHandler(err)
      redirect_to(redirect_to(err.path))
      flash[:error] = err.message
    end
  end  
end
