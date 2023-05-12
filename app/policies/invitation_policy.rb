class InvitationPolicy < ApplicationPolicy
  authorize :team

  def create?
    team.admin? user
  end

  def new?
    create?
  end
end
