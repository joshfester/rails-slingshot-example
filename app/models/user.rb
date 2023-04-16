class User < ApplicationRecord
  include Archivable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :memberships, dependent: :destroy
  has_many :teams, through: :memberships
  has_many :owned_teams, foreign_key: :owner_id, class_name: "Team", inverse_of: :owner, dependent: :destroy
  has_one :personal_team,
    -> { where is_personal: true },
    foreign_key: :owner_id, class_name: "Team", inverse_of: :owner, dependent: :destroy

  enum role: {
    reader: "reader",
    editor: "editor",
    admin: "admin"
  }

  after_create :create_personal_team

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id", "remember_created_at", "reset_password_sent_at", "updated_at"]
  end

  def membership(team:)
    team_memberships.find_by team: team
  end

  private

  def create_personal_team
    Team.create! owner: self, title: "My Team", is_personal: true
  end
end
