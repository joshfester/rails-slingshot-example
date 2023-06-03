class MembershipPolicy < ApplicationPolicy
  authorize :team, optional: true

  alias_rule :update?, to: :edit?

  def index?
    team.member? user
  end

  def edit?
    record.team.admin? user
  end

  def destroy?
    edit? && record.team.admin_users.size > 1
  end
end
