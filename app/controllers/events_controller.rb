class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

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
    @event = Event.new(event_params)

    begin 
      errorIfNoPermission(params[:organisation_id])
      respond_to do |format|
        if @event.save
          format.html { redirect_to @event, notice: 'Event was successfully created.' }
          format.json { render :show, status: :created, location: @event }
        else
          format.html { render :new }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
      
    rescue ErrorWithRedirect => err
      ErrorWithRedirect.defaultHandler(err)
    rescue Exception => err
      redirect_to(root_path)
      flash[:error] = err.message
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update

    begin
      errorIfNoPermission(@event.organisation_id)
      respond_to do |format|
        if @event.update(event_params)
          format.html { redirect_to @event, notice: 'Event was successfully updated.' }
          format.json { render :show, status: :ok, location: @event }
        else
          format.html { render :edit }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
      
    rescue ErrorWithRedirect => err
      ErrorWithRedirect.defaultHandler(err, @event)
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
      ErrorWithRedirect.defaultHandler(err)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    def errorIfNoPermission(organisation_id)
      org = Organisation.find_by(id: organisation_id)
      raise(ErrorWithRedirect.new('Not a contributor for this organisation',
        root_path)) if !contributor?(org)
      raise(ErrorWithRedirect.new('Not an admin',root_path)) if !@contributor.admin?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      byebug
      params.require(:event).permit(:name, :start_date, :end_date, :address, :city, :postcode, :longitude, :latitude, :organisation_id)
    end
end
