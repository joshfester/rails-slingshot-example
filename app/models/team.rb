class Team < ApplicationRecord
  include Archivable

  has_many :invitations, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  def admin?(user:)
    membership(user: user)&.role == "admin"
  end

  def member?(user:)
    membership(user: user)&.present?
  end

  def membership(user:)
    memberships.find_by user: user
  end
end
