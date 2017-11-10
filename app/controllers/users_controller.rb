class UsersController < Clearance::UsersController	
  
  before_action :require_login, only:[:show]
  def show

  end

  def profile

  end

  def user_from_params
    email = user_params.delete(:email)
    password = user_params.delete(:password)
    first_name = user_params.delete(:first_name)
    last_name = user_params.delete(:last_name)
    photos = user_params.delete(:photos)
    


    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
      user.first_name = first_name
      user.last_name = last_name
      user.photos = photos
      
    end
  end
<<<<<<< HEAD

  def feed

      if !signed_in?
        redirect_to Clearance.configuration.redirect_url
      end 
   end 
=======
>>>>>>> master
end