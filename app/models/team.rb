class Team < ApplicationRecord
  include Archivable

  belongs_to :owner, class_name: "User"
end
