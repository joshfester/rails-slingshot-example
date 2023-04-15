class Membership < ApplicationRecord
  include MembershipRole

  belongs_to :user
  belongs_to :team
end
