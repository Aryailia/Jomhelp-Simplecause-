class UsersController < Clearance::UsersController	
  
  before_action :require_login, only:[:show]
  def show

  end

  def user_from_params
    email = user_params.delete(:email)
    password = user_params.delete(:password)
    first_name = user_params.delete(:first_name)
    last_name = user_params.delete(:last_name)
    


    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
      user.first_name = first_name
      user.role = "customer"
      
    end
  end
end