class AttendeesController < ApplicationController
  def create
    attendee = Attendee.new(attendee_params)
    begin
      refresh = event_path(attendee.event)
      # raise ErrorWithRedirect.new('You must be logged and be admin', refresh) if signed_in? && current_user.admin?
      raise ErrorWithRedirect.new('You must be logged in as that user', refresh) if !signed_in? || current_user.id != attendee.user_id
      if attendee.save
        respond_to do |format|
          format.html { redirect_to(event_path(attendee.event), notice: 'Signed up for event.') }
          format.json { render(:show, status: :created, location: attendee.event) }
        end
      else
        raise ErrorWithRedirect.new('You are already followed', refresh)
      end
    rescue ErrorWithRedirect => err
      redirect_to(err.path)
      flash[:error] = err.message
    end
	end

  def destroy
    attendee = Attendee.find_by(attendee_params)
    begin
      refresh = event_path(attendee.event)
      raise ErrorWithRedirect.new('Invalid event or user id', refersh) if attendee.nil?
      # raise ErrorWithRedirect.new('You must be logged and be admin', refersh) if signed_in? && current_user.admin?
      raise ErrorWithRedirect.new('You must be logged in as that user', refersh) if !signed_in? || current_user.id != attendee.user_id
      if attendee.destroy
        respond_to do |format|
          format.html { redirect_to(event_path(attendee.event), notice: 'Not attend success.') }
          format.json { render(:show, status: :created, location: attendee.event) }
        end
      else
        raise ErrorWithRedirect.new('You are already followed', refersh)
      end
    rescue ErrorWithRedirect => err
      redirect_to(err.path)
      flash[:error] = err.message
    end
	end


	private
  def attendee_params
    params.require(:attendee).permit(:event_id, :user_id)
  end

  def check_admin
		if !@contributor.admin?
 			redirect_to organisation_path(@organisation)
 		end
  end
end