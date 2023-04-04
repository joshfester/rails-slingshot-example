# frozen_string_literal: true

module Teams
  class TeamComponent < ApplicationComponent
    def initialize(resource:)
      @resource = resource
    end

  end
end