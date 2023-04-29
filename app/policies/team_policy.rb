class TeamPolicy < ApplicationPolicy
  def show?
    record.member? user: user
  end
end
