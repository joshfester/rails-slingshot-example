class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resource, only: %i[show edit update destroy]

  # GET /teams
  def index
    @resources = Current.user.teams
  end

  # GET /teams/1
  def show
    authorize! @resource
  end

  # GET /teams/new
  def new
    @resource = Team.new owner: Current.user
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  def create
    @resource = Team.new resource_params.merge(owner: Current.user)

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
    @resource.destroy
    redirect_to teams_url, notice: "Team was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_resource
    @resource = Team.find params[:id]
  end

  # Only allow a list of trusted parameters through.
  def resource_params
    params.fetch(:team, {}).permit :title
  end
end
