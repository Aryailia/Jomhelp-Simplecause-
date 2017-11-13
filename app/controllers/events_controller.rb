class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def verify_voucher
    x = Event.find_by(id: params[:event_id])

    if params[:event][:voucher] ==  x.voucher
      a = current_user
      a.points += 10

      if a.points < 100
        a.level = 1        
      elsif a.points >= 100 && a.points <200
        a.level = 2
      elsif a.points >= 200
        a.level = 3
      end
      a.save
      redirect_to(root_path)
    else
      redirect_to(profile_path)
    end
   
  end

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end




  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
    @event.voucher = SecureRandom.hex(4)
    @event.save
    begin
      errorIfNoPermission(params[:organisation_id])
      
    rescue ErrorWithRedirect => err
      redirect_to(err.path)
      flash[:error] = err.message
    rescue Exception => err
      redirect_to(root_path)
      flash[:error] = err.message
    end
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create


    

    begin 
      @event = Event.new(event_params)
      @event.voucher = SecureRandom.hex(4)
      @event.save
      errorIfNoPermission(params[:organisation_id])
      test = @event.save
      raise(ErrorWithRedirect.new(@event.errors),
        organisation_path(params[:organisation_id])) if !test
      respond_to do |format|
        @post = current_user.posts.new(content: "#{current_user.first_name} #{current_user.last_name} have created an event that you might want to join" , organisation_id: params[:organisation_id], event_created: true)
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
        # respond_to do |format| on error
          # format.html { render :new }
          # format.json { render json: @event.errors, status: :unprocessable_entity }
        # end
      end
      
    rescue ErrorWithRedirect => err
      redirect_to(err.path)
      flash[:error] = err.message
    rescue Exception => err
      redirect_to(root_path)
      flash[:error] = err.message
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update

    begin
      orgId = @event.organisation_id
      errorIfNoPermission(orgId)
      @post = current_user.posts.new(content: "#{current_user.first_name} #{current_user.last_name} have created an event that you might want to join" , organisation_id: params[:organisation_id], event_created: true)
      test = @event.update(event_params)
      raise(ErrorWithRedirect.new(
        @event.errors.messages.map { |k, value| "#{k}: #{value}" }.join(''),
        organisation_path(orgId))) if !test
      respond_to do |format|
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      end
      # respond_to do |format|
        # format.html { render :edit }
        # format.json { render json: @event.errors, status: :unprocessable_entity }
      # end
      
    rescue ErrorWithRedirect => err
      redirect_to(err.path)
      flash[:error] = err.message
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    begin
      errorIfNoPermission(params[:organisation_id])
      @event.destroy
      respond_to do |format|
        format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
        format.json { head :no_content }
      end
    rescue ErrorWithRedirect => err
      redirect_to(err.path)
      flash[:error] = err.message
    end
  end

  def display_organisation_events
    @organisation = Organisation.find(params[:organisation_id])
    events(@organisation)
    @past_events = @past_events.order(start_date: :desc).paginate(:page => params[:page], :per_page => 3)
    @upcoming_events = @upcoming_events.order(start_date: :asc).paginate(:page => params[:page], :per_page => 3)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    def errorIfNoPermission(organisation_id)
      org = Organisation.find_by(id: organisation_id)
      raise(ErrorWithRedirect.new('Organisation not found',
        root_path)) if org.nil?
      raise(ErrorWithRedirect.new('Not a contributor for this organisation',
        root_path)) if !contributor?(org)
      raise(ErrorWithRedirect.new('Not an admin',
        organisation_path(organisation_id))) if !@contributor.admin?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :start_date, :end_date, :address, :city, :postcode, :longitude, :latitude, :organisation_id, {photos: []})
    end
end
