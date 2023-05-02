class Teams::InvitationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team
  before_action :set_resource, only: %i[new create]
  before_action :authorize_resource, only: %i[new create]

  def new
  end

  def create
    @resource.assign_attributes resource_params

    if @resource.save
      redirect_to team_path(@team)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @resources = @team.invitations.load_async
  end

  private

  def set_team
    @team = Team.find params.require(:team_id)
  end

  def resource_params
    params.require(:invitation).permit :email
  end
  
  def authorize_resource
    authorize! @resource 
  end

  def set_resource
    @resource = @team.invitations.build
  end
end
