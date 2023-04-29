class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resource, only: %i[show edit update destroy]
  before_action :authorize_resource, only: %i[show edit update destroy]

  # GET /teams
  def index
    @resources = authorized_scope Team.all
  end

  # GET /teams/1
  def show
  end

  # GET /teams/new
  def new
    @resource = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  def create
    @resource = Team.new resource_params
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
    authorize! @resource
  end

  def set_resource
    @resource = Team.find params[:id]
  end

  def resource_params
    params.fetch(:team, {}).permit :title
  end
end
