class User < ApplicationRecord
  include Clearance::User
  has_many(:attendees); has_many(:events, through: :attendees)
	has_many :follows
	has_many :contributors
	has_many :organisations, through: :contributors 
  has_many :follow_organisations, through: :follows, source: :organisation
	has_many :authentications, dependent: :destroy

	has_many :posts 
	# has_many :post ,through: :organisations
 

  
  has_many :friendships, dependent: :destroy
  has_many :approved_friendships, -> { where(approved: true) }, dependent: :destroy, class_name: 'Friendship'
  has_many :friends, through: :approved_friendships



  has_many :inverse_friendships, dependent: :destroy, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  mount_uploader :photos, PhotoUploader

  def self.create_with_auth_and_hash(authentication, auth_hash)
    user = self.create!(
      first_name: auth_hash["extra"]["raw_info"]["first_name"],
      last_name: auth_hash["extra"]["raw_info"]["last_name"],
      email: auth_hash["extra"]["raw_info"]["email"],
      points: 0,
      #Just putting a random password to fill the column in the database because they're signing in with Facebook 
      password: SecureRandom.hex(6)
    )
    user.authentications << authentication
    return user
  end

  # grab fb_token to access Facebook for user data
  def fb_token
    x = self.authentications.find_by(provider: 'facebook')
    return x.token unless x.nil?
  end
end
