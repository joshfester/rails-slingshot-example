class Current < ActiveSupport::CurrentAttributes
  attribute :membership, :team, :user

  def team=(team)
    super
    self.membership = team.memberships.find_by user: user
  end
end
