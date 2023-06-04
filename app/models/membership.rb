class Membership < ApplicationRecord
  include MembershipRole

  belongs_to :user
  belongs_to :team

  validate :confirm_team_has_admin, unless: :new_record?

  before_destroy :confirm_team_has_admin

  def title
    user.email
  end

  private

  def confirm_team_has_admin
    if team.admin_memberships.filter {|i| i != self }.size == 0
      errors.add :min_admins, "team must have at least one admin"
      throw :abort
    end
  end
end
