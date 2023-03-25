module Archivable
  extend ActiveSupport::Concern

  included do
    scope :not_archived, -> { where(deleted_at: nil) }
    scope :archived, -> { where.not(deleted_at: nil) }
    scope :active, -> { not_archived }
  end

  def active?
    !deleted_at?
  end
end
