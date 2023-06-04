class TeamPolicy < ApplicationPolicy
  def show?
    record.member? user
  end

  def edit?
    record.admin? user
  end

  def new?
    user.present?
  end

  def create?
    user.present?
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  relation_scope do |relation|
    relation.active.joins(:memberships).where(memberships: {user: user})
  end
end
