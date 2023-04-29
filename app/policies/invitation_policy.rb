class InvitationPolicy < ApplicationPolicy
  def create?
    user.team_admin? team: record.team
  end
end
