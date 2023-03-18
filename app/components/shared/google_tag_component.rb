# frozen_string_literal: true

module Shared
  class GoogleTagComponent < ApplicationComponent
    def initialize(id:)
      @id = id
    end

    private

    def render?
      @id.present?
    end
  end
end
