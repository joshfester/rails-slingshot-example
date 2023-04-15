class Invitation < ApplicationRecord
  include MembershipRole

  belongs_to :from_membership, class_name: "Membership"
  belongs_to :team

  private

  def generate_acceptance_token
    signed_id expires_in: 7.days, purpose: :accept_invitation
  end
end
