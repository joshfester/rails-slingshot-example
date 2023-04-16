# frozen_string_literal: true

class Memberships::ListItemComponent < ApplicationComponent
  with_collection_parameter :resource
  
  def initialize(resource:)
    @resource = resource
  end

end
