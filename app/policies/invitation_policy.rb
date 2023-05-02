class InvitationPolicy < ApplicationPolicy
  def create?
    record.team.admin? user: user
  end

  def new?
    create?
  end
end
