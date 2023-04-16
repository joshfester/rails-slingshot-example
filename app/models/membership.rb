class Membership < ApplicationRecord
  include MembershipRole

  belongs_to :user
  belongs_to :team

  def title
    user.email
  end
end
