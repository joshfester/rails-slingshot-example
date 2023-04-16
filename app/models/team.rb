class Team < ApplicationRecord
  include Archivable

  belongs_to :owner, class_name: "User"
  has_many :invitations, dependent: :destroy
  has_many :memberships, dependent: :destroy
end
