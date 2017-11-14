class OrganisationsController < ApplicationController
  before_action :set_organisation, only: [:show, :edit, :update, :destroy, :admin_dashboard]

  # GET /organisations
  # GET /organisations.json
  def index
    @organisations = Organisation.order("created_at DESC").all.paginate(:page => params[:page], :per_page => 6)
  end

  # GET /organisations/1
  # GET /organisations/1.json
  def show
    @post = Post.new
    @posts= Post.where(organisation_id: @organisation.id).order('created_at DESC').paginate(:page => params[:page], :per_page => 5)
    @comment = Comment.new
    @admin = Organisation.find(params[:id])
     @organisation  = Organisation.find(params[:id])
    if signed_in?
      if contributor?(@organisation) 
        @contributors = @organisation.contributors.find_by(user_id: current_user.id)
        if @contributor.admin?
        end
      end
    end
  end

  # GET /organisations/new
  def new
    if signed_in?
      @organisation = Organisation.new
    else
      redirect_to sign_up_path
    end
  end

  # GET /organisations/1/edit
  def edit
    @organisation = Organisation.find(params[:id])
    if !contributor?(@organisation)
      if !@contributor.admin?
        redirect_to organisation_path(@organisation)
      end
    end
  end

  # POST /organisations
  # POST /organisations.json
  def create
    if signed_in?
      @organisation = Organisation.new(organisation_params)
      @organisation.email = current_user.email

      respond_to do |format|
        if @organisation.save
          a = Contributor.new(organisation_id: @organisation.id, user_id: current_user.id, role: 2, approval_request: true)
          a.save
          b = Follow.new(organisation_id: @organisation.id, user_id: current_user.id)
          b.save
          format.html { redirect_to @organisation, notice: 'Organisation was successfully created.' }
          format.json { render :show, status: :created, location: @organisation }
        else
          format.html { render :new }
          format.json { render json: @organisation.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to sign_up_path
    end
  end

  # PATCH/PUT /organisations/1
  # PATCH/PUT /organisations/1.json
  def update
    respond_to do |format|
      if @organisation.update(organisation_params)
        format.html { redirect_to @organisation, notice: 'Organisation was successfully updated.' }
        format.json { render :show, status: :ok, location: @organisation }
      else
        format.html { render :edit }
        format.json { render json: @organisation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organisations/1
  # DELETE /organisations/1.json
  def destroy
    @organisation.destroy
    respond_to do |format|
      format.html { redirect_to organisations_url, notice: 'Organisation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def admin_dashboard
    if !contributor?(@organisation)
      redirect_to organisation_path(@organisation)
    end
    @followers = @organisation.follows
    events(@organisation)
  end

  private
    def organisation_params
      params.require(:organisation).permit(:email, :name, :address, :city, :postcode, :description, {photos: []})
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_organisation
      @organisation = Organisation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # def organisation_params
    #   params.fetch(:organisation, {})
    # end
end
