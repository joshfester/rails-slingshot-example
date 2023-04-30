class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resource, except: %i[index]
  before_action :authorize_resource, except: %i[index]

  # GET /teams
  def index
    @pagy, @resources = pagy authorized_scope(Team.all)
  end

  # GET /teams/1
  def show
  end

  # GET /teams/new
  def new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  def create
    @resource.assign_attributes resource_params
    @resource.memberships.build user: Current.user, role: :admin

    if @resource.save
      redirect_to @resource, notice: "Team was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /teams/1
  def update
    if @resource.update(resource_params)
      redirect_to @resource, notice: "Team was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /teams/1
  def destroy
    @resource.archive
    redirect_to teams_url, notice: "Team was successfully deleted."
  end

  private

  def authorize_resource
    if params[:id].present?
      authorize! @resource 
    else
      authorize! :team
    end
  end

  def set_resource
    @resource = if params[:id].present?
      Team.find(params[:id]) 
    else
      Team.new
    end
  end

  def resource_params
    params.fetch(:team, {}).permit :title
  end
end
