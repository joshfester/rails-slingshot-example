class MembershipPolicy < ApplicationPolicy
  def edit?
    record.team.admin? user
  end

  def update?
    edit?
  end

  def destroy?
    edit? && record.team.admin_users.size > 1
  end
end
