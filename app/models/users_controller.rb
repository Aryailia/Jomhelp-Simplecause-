class UsersController < ApplicationController

def follow(user_id)
    following_relationships.create(following_id: user_id)
  end

 def unfollow(user_id)
    following_relationships.find_by(following_id: user_id).destroy
  end

end 