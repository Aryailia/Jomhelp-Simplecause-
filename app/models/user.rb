class User < ApplicationRecord
  has_many :follows	
  include Clearance::User
end
