class User < ApplicationRecord
  include Archivable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :team_memberships
  has_many :teams, through: :team_memberships
  has_many :owned_teams, as: :owner
  has_one :personal_team, -> { where owner: self, is_personal: true }, through: :owned_teams

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
    Team.create! owner: self, title: "My Team", is_personal: true
  end
end
