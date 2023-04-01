class TeamMembership < ApplicationRecord
  has_secure_token :invite_token

  belongs_to :user
  belongs_to :team

  enum role: {
    member: "member",
    admin: "admin"
  }
end
