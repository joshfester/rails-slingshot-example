class Teams::InvitationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team

  def new
    @resource = @team.invitations.build
  end

  def create
    @resource = @team.invitations.build resource_params

    authorize! @resource

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
end
