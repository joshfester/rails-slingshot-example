class TeamPolicy < ApplicationPolicy
  def show?
    record.member? user: user
  end

  def edit?
    record.admin? user: user
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  relation_scope do |relation|
    relation.active.joins(:memberships).where(memberships: { user: user })
  end
end
