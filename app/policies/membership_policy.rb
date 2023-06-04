class MembershipPolicy < ApplicationPolicy
  authorize :team, optional: true

  def index?
    team.member? user
  end

  def edit?
    record.team.admin? user
  end

  def update?
    record.team.admin? user
  end

  def destroy?
    record.team.admin? user
  end
end
