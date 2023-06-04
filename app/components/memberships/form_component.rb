# frozen_string_literal: true

class Memberships::FormComponent < ApplicationComponent
  def initialize(resource:)
    @resource = resource
  end
end
