class TeamMembership < ApplicationRecord
  belongs_to :user
  belongs_to :team

  enum role: {
    member: "member",
    admin: "admin"
  }

  def accept!
    update! accepted_at: Time.current
  end

  private

  def generate_acceptance_token
    signed_id expires_in: 7.days, purpose: :accept_invite
  end
end
