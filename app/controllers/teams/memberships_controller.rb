class Teams::MembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team

  def index
    @resources = @team.memberships.includes(:user).load_async
  end

  private

  def set_team
    @team = Team.find params.require(:team_id)
  end
end
