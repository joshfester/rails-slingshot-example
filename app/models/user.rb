class User < ApplicationRecord
  include Archivable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :memberships, dependent: :destroy
  has_many :teams, through: :memberships
  has_one :personal_team_membership, -> { joins(:team).where(teams: {is_personal: true}) },
    class_name: "Membership",
    dependent: :nullify,
    inverse_of: :user
  has_one :personal_team, through: :personal_team_membership, source: :team

  enum role: {
    reader: "reader",
    editor: "editor",
    admin: "admin"
  }

  after_create :create_personal_team

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id", "remember_created_at", "reset_password_sent_at", "updated_at"]
  end

  private

  def create_personal_team
    team = Team.new title: "My Team", is_personal: true
    team.memberships.build user: self, role: :admin
    team.save!
  end
end
