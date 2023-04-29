class Team < ApplicationRecord
  include Archivable

  belongs_to :owner, class_name: "User"
  has_many :invitations, dependent: :destroy
  has_many :memberships, dependent: :destroy

  def admin?(user:)
    owner_id == user.id ||
      memberships.find_by(user: user)&.role == "admin"
  end

  def member?(user:)
    owner_id == user.id ||
      memberships.find_by(user: user).present?
  end
end
