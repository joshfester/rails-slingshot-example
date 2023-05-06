class InvitationPolicy < ApplicationPolicy
  authorize :team

  def create?
    team.admin? user: user
  end

  def new?
    create?
  end
end
