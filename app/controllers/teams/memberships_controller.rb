class Teams::MembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team
  before_action :set_resource, only: %i[edit update destroy]
  before_action :authorize_resource, only: %i[edit update destroy]

  def index
    authorize! :membership, context: {team: @team}
    @pagy, @resources = pagy @team.memberships.includes(:user).order(created_at: :desc)
  end

  def edit

  end

  def update

  end

  def destroy
    if @resource.destroy
      flash[:notice] = "User removed from team"
    else
      flash[:danger] = "Unable to remove user from team"
    end

    redirect_link = if @team.member?(Current.user)
      team_path(@team) 
    else
      root_path
    end

    redirect_to redirect_link
  end

  private

  def authorize_resource
    authorize! @resource
  end

  def set_resource
    @resource = Membership.find params.require(:id)
  end

  def set_team
    @team = Team.find params.require(:team_id)
  end
end
