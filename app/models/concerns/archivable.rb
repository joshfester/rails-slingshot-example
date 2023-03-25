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

  def archive
    update deleted_at: Time.zone.now
  end

  def restore
    update deleted_at: nil
  end
end
