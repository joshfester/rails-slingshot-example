# frozen_string_literal: true

module Teams
  class ListItemComponent < ApplicationComponent
    with_collection_parameter :resource

    def initialize(resource:)
      @resource = resource
    end
  end
end
