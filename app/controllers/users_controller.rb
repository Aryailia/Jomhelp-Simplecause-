class UsersController < Clearance::UsersController	
  
  before_action :require_login, only:[:show]
  def show
    @user = User.find_by(id: params[:id])
    @points = @user.points.to_i % 100
    if current_user == @user
      @status = true
    else
      @status = false
    end
  end

  def create
    @user = user_from_params
    @user.points = 0
    @user.level = 1
    if @user.save
      sign_in @user
      redirect_to organisations_path
    else
      render template: "users/new"
    end
  end

  def user_from_params
    email = user_params.delete(:email)
    password = user_params.delete(:password)
    first_name = user_params.delete(:first_name)
    last_name = user_params.delete(:last_name)
    photos = user_params.delete(:photos)
    points = 0
    level = 1


    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
      user.first_name = first_name
      user.last_name = last_name
      user.photos = photos
      user.points = points
      user.level = level
    end
  end


  def feed
    if signed_in?
      @follows = current_user.follow_organisations.limit(8).order('created_at DESC')
      @events = current_user.events.limit(5).order('created_at DESC')
    else
      redirect_to sign_in_path
    end 
  end 

end