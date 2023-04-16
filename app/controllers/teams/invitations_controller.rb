class Teams::InvitationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team

  def new
    @resource = @team.invitations.build
  end

  def index
    @resources = @team.invitations.load_async
  end

  private

  def set_team
    @team = Team.find(params.require(:team_id))
  end
end
