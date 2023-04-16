class Team < ApplicationRecord
  include Archivable

  belongs_to :owner, class_name: "User"
  has_many :invitations
  has_many :memberships
end
