class Team < ApplicationRecord
  include Archivable

  has_many :invitations, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  def admin?(user:)
    memberships.find_by(user: user)&.role == "admin"
  end

  def member?(user:)
    memberships.find_by(user: user).present?
  end
end
