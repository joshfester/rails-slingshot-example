# frozen_string_literal: true

module Teams
  class FormComponent < ApplicationComponent
    def initialize(resource:)
      @resource = resource
    end
  end
end
